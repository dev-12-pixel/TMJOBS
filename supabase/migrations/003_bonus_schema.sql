-- Bonus rules (business logic, not hardcoded amounts) and the resulting records.

CREATE TABLE IF NOT EXISTS public.bonus_rules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  platform_id UUID NOT NULL REFERENCES public.platforms(id) ON DELETE CASCADE,
  event TEXT NOT NULL DEFAULT 'hired' CHECK (event = 'hired'),
  hours_requirement NUMERIC(6,2) NOT NULL DEFAULT 0,
  amount NUMERIC(10,2) NOT NULL,
  currency TEXT NOT NULL DEFAULT 'USD',
  one_time_per_candidate BOOLEAN NOT NULL DEFAULT false,
  effective_from TIMESTAMPTZ NOT NULL DEFAULT now(),
  effective_to TIMESTAMPTZ,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_bonus_rules_platform_id ON public.bonus_rules(platform_id);

ALTER TABLE public.bonus_rules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view bonus rules" ON public.bonus_rules
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can manage bonus rules" ON public.bonus_rules
  FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

-- Finds the bonus rule in effect for a platform right now.
CREATE OR REPLACE FUNCTION public.active_bonus_rule(p_platform_id UUID, p_at TIMESTAMPTZ DEFAULT now())
RETURNS public.bonus_rules AS $$
  SELECT * FROM public.bonus_rules
  WHERE platform_id = p_platform_id
    AND active
    AND effective_from <= p_at
    AND (effective_to IS NULL OR effective_to >= p_at)
  ORDER BY effective_from DESC
  LIMIT 1;
$$ LANGUAGE sql STABLE;

CREATE TABLE IF NOT EXISTS public.bonus_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referral_id UUID NOT NULL REFERENCES public.referrals(id) ON DELETE CASCADE,
  bonus_rule_id UUID NOT NULL REFERENCES public.bonus_rules(id) ON DELETE RESTRICT,
  candidate_id UUID NOT NULL REFERENCES public.candidates(id) ON DELETE CASCADE,
  one_time_per_candidate BOOLEAN NOT NULL DEFAULT false,
  amount NUMERIC(10,2) NOT NULL,
  currency TEXT NOT NULL DEFAULT 'USD',
  status TEXT NOT NULL DEFAULT 'expected' CHECK (status IN ('expected', 'remaining', 'paid', 'disputed')),
  earned_at TIMESTAMPTZ,
  paid_at TIMESTAMPTZ,
  exchange_rate_used NUMERIC(10,4),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (referral_id)
);

-- Stops paying the same candidate twice on a one-time-per-candidate rule
-- (e.g. Micro1) without hardcoding which platform that applies to.
CREATE UNIQUE INDEX IF NOT EXISTS uidx_bonus_records_one_time_per_candidate
  ON public.bonus_records (candidate_id, bonus_rule_id)
  WHERE one_time_per_candidate;

CREATE INDEX IF NOT EXISTS idx_bonus_records_candidate_id ON public.bonus_records(candidate_id);
CREATE INDEX IF NOT EXISTS idx_bonus_records_status ON public.bonus_records(status);

ALTER TABLE public.bonus_records ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view bonus records" ON public.bonus_records
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can manage bonus records" ON public.bonus_records
  FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

-- Candidate status (Hired) and bonus status are independent: hiring status
-- drives whether a bonus_record exists/what it's worth, but paid/disputed is
-- always a manual human decision this function never overwrites.
CREATE OR REPLACE FUNCTION public.sync_bonus_record()
RETURNS TRIGGER AS $$
DECLARE
  rule public.bonus_rules;
  existing public.bonus_records;
  computed_status TEXT;
BEGIN
  SELECT * INTO existing FROM public.bonus_records WHERE referral_id = NEW.id;

  IF NEW.status != 'hired' THEN
    IF FOUND AND existing.status IN ('expected', 'remaining') THEN
      DELETE FROM public.bonus_records WHERE id = existing.id;
    END IF;
    RETURN NEW;
  END IF;

  SELECT * INTO rule FROM public.active_bonus_rule(NEW.platform_id, NEW.hired_at);
  IF rule.id IS NULL THEN
    RETURN NEW;
  END IF;

  computed_status := CASE WHEN NEW.hours_completed >= rule.hours_requirement THEN 'remaining' ELSE 'expected' END;

  IF existing.id IS NOT NULL THEN
    IF existing.status IN ('expected', 'remaining') THEN
      UPDATE public.bonus_records
      SET status = computed_status,
          earned_at = COALESCE(earned_at, now()),
          updated_at = now()
      WHERE id = existing.id;
    END IF;
  ELSE
    IF rule.one_time_per_candidate AND EXISTS (
      SELECT 1 FROM public.bonus_records
      WHERE candidate_id = NEW.candidate_id AND bonus_rule_id = rule.id
    ) THEN
      -- Candidate already has a bonus record against this one-time rule
      -- (via a different referral) - do not create a second payable record.
      RETURN NEW;
    END IF;

    INSERT INTO public.bonus_records (
      referral_id, bonus_rule_id, candidate_id, one_time_per_candidate,
      amount, currency, status, earned_at
    ) VALUES (
      NEW.id, rule.id, NEW.candidate_id, rule.one_time_per_candidate,
      rule.amount, rule.currency, computed_status, now()
    );
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_sync_bonus_record ON public.referrals;
CREATE TRIGGER trigger_sync_bonus_record
  AFTER INSERT OR UPDATE OF status, hours_completed ON public.referrals
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_bonus_record();

-- Currency conversion, with the rate at time of payment preserved on the record
-- rather than recomputed later if the rate changes.
CREATE TABLE IF NOT EXISTS public.exchange_rates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  currency_from TEXT NOT NULL,
  currency_to TEXT NOT NULL,
  rate NUMERIC(10,4) NOT NULL,
  effective_date DATE NOT NULL DEFAULT current_date,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (currency_from, currency_to, effective_date)
);

ALTER TABLE public.exchange_rates ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view exchange rates" ON public.exchange_rates
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can manage exchange rates" ON public.exchange_rates
  FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

CREATE OR REPLACE FUNCTION public.mark_bonus_paid(p_bonus_record_id UUID, p_payment_method TEXT DEFAULT NULL)
RETURNS public.bonus_records AS $$
DECLARE
  latest_rate NUMERIC(10,4);
  result public.bonus_records;
BEGIN
  SELECT rate INTO latest_rate FROM public.exchange_rates
  WHERE currency_from = 'USD' AND currency_to = 'PKR'
  ORDER BY effective_date DESC LIMIT 1;

  UPDATE public.bonus_records
  SET status = 'paid', paid_at = now(), exchange_rate_used = latest_rate,
      notes = COALESCE(p_payment_method, notes), updated_at = now()
  WHERE id = p_bonus_record_id
  RETURNING * INTO result;

  RETURN result;
END;
$$ LANGUAGE plpgsql;
