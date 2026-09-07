-- Mock volume data for demo/testing purposes (no production data existed to
-- preserve). Real bonus amounts and account names are placeholders - correct
-- them via the Platforms/Accounts/Bonuses pages.

CREATE OR REPLACE FUNCTION public.seed_mock_referrals(
  p_platform_id UUID, p_total INT, p_hired INT, p_prefix TEXT
) RETURNS VOID AS $$
DECLARE
  account_ids UUID[];
  job_ids UUID[];
  first_names TEXT[] := ARRAY['Ali','Sara','Ahmed','Usman','Hina','Bilal','Ayesha','Zain','Mariam','Hamza','Fatima','Omar','Nida','Kashif','Sana','Rizwan'];
  last_names TEXT[] := ARRAY['Khan','Ahmed','Ali','Malik','Butt','Sheikh','Raza','Iqbal','Farooq','Javed','Qureshi','Hassan'];
  rule RECORD;
  cand_id UUID;
  i INT;
  status TEXT;
  ref_date TIMESTAMPTZ;
  applied TIMESTAMPTZ;
  hired TIMESTAMPTZ;
  not_hired TIMESTAMPTZ;
  hours NUMERIC;
  bucket INT;
BEGIN
  SELECT array_agg(id ORDER BY name) INTO account_ids FROM public.accounts WHERE platform_id = p_platform_id;
  SELECT array_agg(id ORDER BY title) INTO job_ids FROM public.jobs WHERE platform_id = p_platform_id;
  SELECT * INTO rule FROM public.active_bonus_rule(p_platform_id);

  FOR i IN 1..p_total LOOP
    INSERT INTO public.candidates (first_name, last_name, email, phone)
    VALUES (
      first_names[1 + (i % array_length(first_names, 1))],
      last_names[1 + (i % array_length(last_names, 1))],
      lower(p_prefix) || '.candidate.' || i || '@example.test',
      -- platform-specific digit keeps phone numbers unique across platforms
      -- (otherwise candidate #1 of each platform would collide on phone).
      '+9230' || (CASE p_prefix WHEN 'turing' THEN '1' WHEN 'marcor' THEN '2' ELSE '3' END) || lpad(i::text, 6, '0')
    )
    RETURNING id INTO cand_id;

    ref_date := now() - ((1 + (i * 37) % 150) || ' days')::interval;
    applied := NULL; hired := NULL; not_hired := NULL; hours := 0;

    IF i <= p_hired THEN
      status := 'hired';
      applied := ref_date + interval '3 days';
      hired := ref_date + interval '12 days';
      hours := COALESCE(rule.hours_requirement, 0);
    ELSE
      bucket := (i - p_hired) % 5;
      IF bucket IN (0, 1, 2) THEN
        status := 'not_hired';
        applied := ref_date + interval '3 days';
        not_hired := ref_date + interval '9 days';
      ELSIF bucket = 3 THEN
        status := 'applied';
        applied := ref_date + interval '3 days';
      ELSE
        status := 'referred';
      END IF;
    END IF;

    INSERT INTO public.referrals (
      candidate_id, platform_id, account_id, job_id, status,
      referral_date, applied_at, hired_at, not_hired_at, hours_completed
    ) VALUES (
      cand_id, p_platform_id,
      account_ids[1 + (i % array_length(account_ids, 1))],
      job_ids[1 + (i % array_length(job_ids, 1))],
      status, ref_date, applied, hired, not_hired, hours
    );

    IF status = 'hired' AND i % 4 = 0 THEN
      -- Log a couple of emails for a subset of hired candidates for realism.
      INSERT INTO public.emails (candidate_id, direction, email_type, subject, sent_at)
      VALUES (cand_id, 'sent', 'initial_contact', 'Referral opportunity', ref_date);
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT public.seed_mock_referrals('22222222-2222-2222-2222-222222222222', 423, 107, 'turing');
SELECT public.seed_mock_referrals('11111111-1111-1111-1111-111111111111', 80, 20, 'marcor');
SELECT public.seed_mock_referrals('33333333-3333-3333-3333-333333333333', 276, 98, 'micro1');
