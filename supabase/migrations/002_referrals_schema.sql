-- Referrals: the event linking a candidate to a platform, account and job.

CREATE TABLE IF NOT EXISTS public.referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES public.candidates(id) ON DELETE CASCADE,
  platform_id UUID NOT NULL REFERENCES public.platforms(id) ON DELETE CASCADE,
  account_id UUID NOT NULL REFERENCES public.accounts(id) ON DELETE RESTRICT,
  job_id UUID NOT NULL REFERENCES public.jobs(id) ON DELETE RESTRICT,
  status TEXT NOT NULL DEFAULT 'referred' CHECK (status IN ('referred', 'applied', 'hired', 'not_hired')),
  referral_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  applied_at TIMESTAMPTZ,
  hired_at TIMESTAMPTZ,
  not_hired_at TIMESTAMPTZ,
  hours_completed NUMERIC(6,2) NOT NULL DEFAULT 0,
  notes TEXT,
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  -- One referral account per candidate+platform+job: re-referring the same person
  -- to the same job on the same platform through a second account is not allowed.
  UNIQUE (candidate_id, platform_id, job_id)
);

CREATE INDEX IF NOT EXISTS idx_referrals_candidate_id ON public.referrals(candidate_id);
CREATE INDEX IF NOT EXISTS idx_referrals_platform_id ON public.referrals(platform_id);
CREATE INDEX IF NOT EXISTS idx_referrals_account_id ON public.referrals(account_id);
CREATE INDEX IF NOT EXISTS idx_referrals_job_id ON public.referrals(job_id);
CREATE INDEX IF NOT EXISTS idx_referrals_status ON public.referrals(status);
CREATE INDEX IF NOT EXISTS idx_referrals_referral_date ON public.referrals(referral_date);

-- A job must belong to the same platform as the referral (guards the cascading
-- Platform -> Account -> Job selection the UI enforces).
CREATE OR REPLACE FUNCTION public.check_referral_consistency()
RETURNS TRIGGER AS $$
DECLARE
  account_platform UUID;
  job_platform UUID;
BEGIN
  SELECT platform_id INTO account_platform FROM public.accounts WHERE id = NEW.account_id;
  SELECT platform_id INTO job_platform FROM public.jobs WHERE id = NEW.job_id;
  IF account_platform IS DISTINCT FROM NEW.platform_id THEN
    RAISE EXCEPTION 'account % does not belong to platform %', NEW.account_id, NEW.platform_id;
  END IF;
  IF job_platform IS DISTINCT FROM NEW.platform_id THEN
    RAISE EXCEPTION 'job % does not belong to platform %', NEW.job_id, NEW.platform_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_check_referral_consistency ON public.referrals;
CREATE TRIGGER trigger_check_referral_consistency
  BEFORE INSERT OR UPDATE ON public.referrals
  FOR EACH ROW
  EXECUTE FUNCTION public.check_referral_consistency();

-- Status-change bookkeeping: stamp the relevant *_at column and touch updated_at.
CREATE OR REPLACE FUNCTION public.stamp_referral_status()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'applied' AND (OLD IS NULL OR OLD.status != 'applied') THEN
    NEW.applied_at := COALESCE(NEW.applied_at, now());
  ELSIF NEW.status = 'hired' AND (OLD IS NULL OR OLD.status != 'hired') THEN
    NEW.hired_at := COALESCE(NEW.hired_at, now());
  ELSIF NEW.status = 'not_hired' AND (OLD IS NULL OR OLD.status != 'not_hired') THEN
    NEW.not_hired_at := COALESCE(NEW.not_hired_at, now());
  END IF;
  NEW.updated_at := now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_stamp_referral_status ON public.referrals;
CREATE TRIGGER trigger_stamp_referral_status
  BEFORE INSERT OR UPDATE ON public.referrals
  FOR EACH ROW
  EXECUTE FUNCTION public.stamp_referral_status();

-- Full status history, so "how long referral -> hire took" is always answerable.
CREATE TABLE IF NOT EXISTS public.referral_status_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referral_id UUID NOT NULL REFERENCES public.referrals(id) ON DELETE CASCADE,
  old_status TEXT,
  new_status TEXT NOT NULL,
  changed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_referral_status_history_referral_id ON public.referral_status_history(referral_id);

CREATE OR REPLACE FUNCTION public.log_referral_status_change()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' OR NEW.status IS DISTINCT FROM OLD.status THEN
    INSERT INTO public.referral_status_history (referral_id, old_status, new_status)
    VALUES (NEW.id, CASE WHEN TG_OP = 'INSERT' THEN NULL ELSE OLD.status END, NEW.status);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_log_referral_status_change ON public.referrals;
CREATE TRIGGER trigger_log_referral_status_change
  AFTER INSERT OR UPDATE ON public.referrals
  FOR EACH ROW
  EXECUTE FUNCTION public.log_referral_status_change();

ALTER TABLE public.referrals ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view referrals" ON public.referrals
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can manage referrals" ON public.referrals
  FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

ALTER TABLE public.referral_status_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view referral status history" ON public.referral_status_history
  FOR SELECT USING (auth.role() = 'authenticated');
