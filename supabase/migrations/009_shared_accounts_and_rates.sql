-- Realistic reseed v2: shared referral accounts across all platforms,
-- updated bonus rates, exact financial targets for Haider/Hanzala, a much
-- larger globally-unique name pool (no more "Name N" suffixes), and
-- synthetic referral dates kept strictly before the earliest real date so
-- real data always sorts first. Does NOT touch users/auth.users.

DELETE FROM public.bonus_records;
DELETE FROM public.referral_status_history;
DELETE FROM public.emails;
DELETE FROM public.referrals;
DELETE FROM public.candidates;
DELETE FROM public.accounts WHERE platform_id IN ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333');

-- Same 5 real referral accounts, now on all 3 platforms.
INSERT INTO public.accounts (platform_id, name, identifier)
SELECT p.id, a.name, a.identifier
FROM (VALUES
  ('11111111-1111-1111-1111-111111111111'::uuid),
  ('22222222-2222-2222-2222-222222222222'::uuid),
  ('33333333-3333-3333-3333-333333333333'::uuid)
) AS p(id)
CROSS JOIN (VALUES
  ('Hanzala', 'hanzala'),
  ('Haider', 'haider'),
  ('Momina Saleem', 'momina'),
  ('Anas Hafeez', 'anas'),
  ('Urwa Hafeez', 'urwa')
) AS a(name, identifier);

-- Updated bonus rates: Turing $150, Marcor $250, Micro1 $100.
UPDATE public.bonus_rules SET amount = 150 WHERE platform_id = '22222222-2222-2222-2222-222222222222';
UPDATE public.bonus_rules SET amount = 250 WHERE platform_id = '11111111-1111-1111-1111-111111111111';
UPDATE public.bonus_rules SET amount = 100 WHERE platform_id = '33333333-3333-3333-3333-333333333333';

DO $$
DECLARE
  turing_id UUID := '22222222-2222-2222-2222-222222222222';
  marcor_id UUID := '11111111-1111-1111-1111-111111111111';
  micro1_id UUID := '33333333-3333-3333-3333-333333333333';
  v_cand_id UUID;
  v_acct_id UUID;
  v_job_id UUID;
BEGIN

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ami' AND last_name = 'Ra' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ami', 'Ra', lower('Ami.Ra') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Rida' AND last_name = 'Atteq' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Rida', 'Atteq', lower('Rida.Atteq') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Rida' AND last_name = 'Ateeq' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Rida', 'Ateeq', lower('Rida.Ateeq') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Rida' AND last_name = 'Ateeq' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Rida', 'Ateeq', lower('Rida.Ateeq') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ami' AND last_name = 'Ra' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ami', 'Ra', lower('Ami.Ra') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Muhammad' AND last_name = 'Amir' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Muhammad', 'Amir', lower('Muhammad.Amir') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-07'::timestamptz - interval '10 days', '2026-04-07'::timestamptz - interval '7 days', '2026-04-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Haider' AND last_name = 'Jamil' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Haider', 'Jamil', lower('Haider.Jamil') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Khaleeq' AND last_name = 'Ur Rehman' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Khaleeq', 'Ur Rehman', lower('Khaleeq.Ur Rehman') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-31'::timestamptz - interval '10 days', '2026-08-31'::timestamptz - interval '7 days', '2026-08-31'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Taiba' AND last_name = 'Khalid' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Taiba', 'Khalid', lower('Taiba.Khalid') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-07'::timestamptz - interval '10 days', '2026-08-07'::timestamptz - interval '7 days', '2026-08-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = '(unknown)' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', '(unknown)', lower('Anas.(unknown)') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmed' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmed', 'Farhan', lower('Ahmed.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-18'::timestamptz - interval '10 days', '2026-08-18'::timestamptz - interval '7 days', '2026-08-18'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-24'::timestamptz - interval '10 days', '2025-12-24'::timestamptz - interval '7 days', '2025-12-24'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ume' AND last_name = 'Habiba' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ume', 'Habiba', lower('Ume.Habiba') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-09'::timestamptz - interval '10 days', '2026-04-09'::timestamptz - interval '7 days', '2026-04-09'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Tanzeel' AND last_name = 'Faisal' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Tanzeel', 'Faisal', lower('Tanzeel.Faisal') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '10 days', '2025-12-19'::timestamptz - interval '7 days', '2025-12-19'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmad' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmad', 'Farhan', lower('Ahmad.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-18'::timestamptz - interval '10 days', '2026-08-18'::timestamptz - interval '7 days', '2026-08-18'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'ABDUL' AND last_name = 'HAFEEZ' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('ABDUL', 'HAFEEZ', lower('ABDUL.HAFEEZ') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-31'::timestamptz - interval '10 days', '2026-08-31'::timestamptz - interval '7 days', '2026-08-31'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Hamna' AND last_name = 'Noor' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Hamna', 'Noor', lower('Hamna.Noor') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-07'::timestamptz - interval '10 days', '2026-08-07'::timestamptz - interval '7 days', '2026-08-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Haider' AND last_name = 'Jamil' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Haider', 'Jamil', lower('Haider.Jamil') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Saif' AND last_name = 'Ur Rehman' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Saif', 'Ur Rehman', lower('Saif.Ur Rehman') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-06'::timestamptz - interval '10 days', '2026-04-06'::timestamptz - interval '7 days', '2026-04-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Saif' AND last_name = 'ur Rehman' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Saif', 'ur Rehman', lower('Saif.ur Rehman') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-06'::timestamptz - interval '10 days', '2026-04-06'::timestamptz - interval '7 days', '2026-04-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Haider' AND last_name = 'Jamil' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Haider', 'Jamil', lower('Haider.Jamil') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ami' AND last_name = 'Ra' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ami', 'Ra', lower('Ami.Ra') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Khaleeq' AND last_name = 'Ur Rehman' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Khaleeq', 'Ur Rehman', lower('Khaleeq.Ur Rehman') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-31'::timestamptz - interval '10 days', '2026-08-31'::timestamptz - interval '7 days', '2026-08-31'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Haider' AND last_name = 'Jamil' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Haider', 'Jamil', lower('Haider.Jamil') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'ABDUL' AND last_name = 'HAFEEZ' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('ABDUL', 'HAFEEZ', lower('ABDUL.HAFEEZ') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-31'::timestamptz - interval '10 days', '2026-08-31'::timestamptz - interval '7 days', '2026-08-31'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-07'::timestamptz - interval '10 days', '2026-08-07'::timestamptz - interval '7 days', '2026-08-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Saif' AND last_name = 'ur Rehman' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Saif', 'ur Rehman', lower('Saif.ur Rehman') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-06'::timestamptz - interval '10 days', '2026-04-06'::timestamptz - interval '7 days', '2026-04-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-07'::timestamptz - interval '10 days', '2026-08-07'::timestamptz - interval '7 days', '2026-08-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmad' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmad', 'Farhan', lower('Ahmad.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-12-17'::timestamptz - interval '10 days', '2026-12-17'::timestamptz - interval '7 days', '2026-12-17'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Muhammad' AND last_name = 'Amir' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Muhammad', 'Amir', lower('Muhammad.Amir') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-07'::timestamptz - interval '10 days', '2026-04-07'::timestamptz - interval '7 days', '2026-04-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Haider' AND last_name = 'Jamil' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Haider', 'Jamil', lower('Haider.Jamil') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-26'::timestamptz - interval '10 days', '2025-12-26'::timestamptz - interval '7 days', '2025-12-26'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-21'::timestamptz - interval '10 days', '2026-05-21'::timestamptz - interval '7 days', '2026-05-21'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Maimuna' AND last_name = 'Javed' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Maimuna', 'Javed', lower('Maimuna.Javed') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-26'::timestamptz - interval '10 days', '2025-12-26'::timestamptz - interval '7 days', '2025-12-26'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Urwa' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Urwa', 'Hafeez', lower('Urwa.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-22'::timestamptz - interval '10 days', '2025-12-22'::timestamptz - interval '7 days', '2025-12-22'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-22'::timestamptz - interval '10 days', '2025-12-22'::timestamptz - interval '7 days', '2025-12-22'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Hamna' AND last_name = 'Noor' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Hamna', 'Noor', lower('Hamna.Noor') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-26'::timestamptz - interval '10 days', '2025-12-26'::timestamptz - interval '7 days', '2025-12-26'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmed' AND last_name = 'Tehseen' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmed', 'Tehseen', lower('Ahmed.Tehseen') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-03-02'::timestamptz - interval '10 days', '2026-03-02'::timestamptz - interval '7 days', '2026-03-02'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Momina' AND last_name = 'Saleem' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Momina', 'Saleem', lower('Momina.Saleem') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-26'::timestamptz - interval '10 days', '2025-12-26'::timestamptz - interval '7 days', '2025-12-26'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Nabel' AND last_name = 'Faisal' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Nabel', 'Faisal', lower('Nabel.Faisal') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-29'::timestamptz - interval '10 days', '2025-12-29'::timestamptz - interval '7 days', '2025-12-29'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahsan' AND last_name = 'Sherazi' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahsan', 'Sherazi', lower('Ahsan.Sherazi') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-23'::timestamptz - interval '10 days', '2025-12-23'::timestamptz - interval '7 days', '2025-12-23'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Tanzeel' AND last_name = 'Faisal' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Tanzeel', 'Faisal', lower('Tanzeel.Faisal') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '10 days', '2025-12-19'::timestamptz - interval '7 days', '2025-12-19'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Muhammad' AND last_name = 'Aslam' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Muhammad', 'Aslam', lower('Muhammad.Aslam') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '10 days', '2025-12-19'::timestamptz - interval '7 days', '2025-12-19'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Hamza' AND last_name = 'Tanveer' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Hamza', 'Tanveer', lower('Hamza.Tanveer') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-26'::timestamptz - interval '10 days', '2025-12-26'::timestamptz - interval '7 days', '2025-12-26'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Mahnoor' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Mahnoor', 'Farhan', lower('Mahnoor.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-05-27'::timestamptz - interval '10 days', '2026-05-27'::timestamptz - interval '7 days', '2026-05-27'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmed' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmed', 'Farhan', lower('Ahmed.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-18'::timestamptz - interval '10 days', '2026-08-18'::timestamptz - interval '7 days', '2026-08-18'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Anas' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Anas', 'Hafeez', lower('Anas.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-06'::timestamptz - interval '10 days', '2026-08-06'::timestamptz - interval '7 days', '2026-08-06'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmad' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmad', 'Farhan', lower('Ahmad.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-18'::timestamptz - interval '10 days', '2026-08-18'::timestamptz - interval '7 days', '2026-08-18'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmed' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmed', 'Farhan', lower('Ahmed.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-18'::timestamptz - interval '10 days', '2026-08-18'::timestamptz - interval '7 days', '2026-08-18'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Hanzala' AND last_name = 'Hafeez' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Hanzala', 'Hafeez', lower('Hanzala.Hafeez') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-04-07'::timestamptz - interval '10 days', '2026-04-07'::timestamptz - interval '7 days', '2026-04-07'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  SELECT id INTO v_cand_id FROM public.candidates WHERE first_name = 'Ahmed' AND last_name = 'Farhan' LIMIT 1;
  IF v_cand_id IS NULL THEN
    INSERT INTO public.candidates (first_name, last_name, email) VALUES ('Ahmed', 'Farhan', lower('Ahmed.Farhan') || '@example.test') RETURNING id INTO v_cand_id;
  END IF;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2026-08-10'::timestamptz - interval '10 days', '2026-08-10'::timestamptz - interval '7 days', '2026-08-10'::timestamptz, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi', 'turing.synth.0@example.test', '+92319690814') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '30 days', '2025-12-19'::timestamptz - interval '30 days' + interval '3 days', '2025-12-19'::timestamptz - interval '30 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Khoza', 'turing.synth.1@example.test', '+92313124430') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '77 days', '2025-12-19'::timestamptz - interval '77 days' + interval '3 days', '2025-12-19'::timestamptz - interval '77 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Ndlovu', 'turing.synth.2@example.test', '+92317867391') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '124 days', '2025-12-19'::timestamptz - interval '124 days' + interval '3 days', '2025-12-19'::timestamptz - interval '124 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Mokoena', 'turing.synth.3@example.test', '+92318218066') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '171 days', '2025-12-19'::timestamptz - interval '171 days' + interval '3 days', '2025-12-19'::timestamptz - interval '171 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Khumalo', 'turing.synth.4@example.test', '+92317173046') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '218 days', '2025-12-19'::timestamptz - interval '218 days' + interval '3 days', '2025-12-19'::timestamptz - interval '218 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Iyer', 'turing.synth.5@example.test', '+92313181636') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '265 days', '2025-12-19'::timestamptz - interval '265 days' + interval '3 days', '2025-12-19'::timestamptz - interval '265 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Nair', 'turing.synth.6@example.test', '+92313389443') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '312 days', '2025-12-19'::timestamptz - interval '312 days' + interval '3 days', '2025-12-19'::timestamptz - interval '312 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Khumalo', 'turing.synth.7@example.test', '+92318675219') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '359 days', '2025-12-19'::timestamptz - interval '359 days' + interval '3 days', '2025-12-19'::timestamptz - interval '359 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Menon', 'turing.synth.8@example.test', '+92316396996') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '406 days', '2025-12-19'::timestamptz - interval '406 days' + interval '3 days', '2025-12-19'::timestamptz - interval '406 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Chauhan', 'turing.synth.9@example.test', '+92319958222') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '33 days', '2025-12-19'::timestamptz - interval '33 days' + interval '3 days', '2025-12-19'::timestamptz - interval '33 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo', 'turing.synth.10@example.test', '+92311262916') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '80 days', '2025-12-19'::timestamptz - interval '80 days' + interval '3 days', '2025-12-19'::timestamptz - interval '80 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Iyer', 'turing.synth.11@example.test', '+92315908289') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '127 days', '2025-12-19'::timestamptz - interval '127 days' + interval '3 days', '2025-12-19'::timestamptz - interval '127 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Nkosi', 'turing.synth.12@example.test', '+92319342303') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '174 days', '2025-12-19'::timestamptz - interval '174 days' + interval '3 days', '2025-12-19'::timestamptz - interval '174 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Mehta', 'turing.synth.13@example.test', '+92315409821') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '221 days', '2025-12-19'::timestamptz - interval '221 days' + interval '3 days', '2025-12-19'::timestamptz - interval '221 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Siddharth', 'Nkosi', 'turing.synth.14@example.test', '+92313530308') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '268 days', '2025-12-19'::timestamptz - interval '268 days' + interval '3 days', '2025-12-19'::timestamptz - interval '268 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Sithole', 'turing.synth.15@example.test', '+92313606604') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '315 days', '2025-12-19'::timestamptz - interval '315 days' + interval '3 days', '2025-12-19'::timestamptz - interval '315 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Rao', 'turing.synth.16@example.test', '+92313946979') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '362 days', '2025-12-19'::timestamptz - interval '362 days' + interval '3 days', '2025-12-19'::timestamptz - interval '362 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu', 'turing.synth.17@example.test', '+92316196491') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '409 days', '2025-12-19'::timestamptz - interval '409 days' + interval '3 days', '2025-12-19'::timestamptz - interval '409 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Verma', 'turing.synth.18@example.test', '+92313199888') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '36 days', '2025-12-19'::timestamptz - interval '36 days' + interval '3 days', '2025-12-19'::timestamptz - interval '36 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Kumar', 'turing.synth.19@example.test', '+92319318786') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '83 days', '2025-12-19'::timestamptz - interval '83 days' + interval '3 days', '2025-12-19'::timestamptz - interval '83 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Iyer', 'turing.synth.20@example.test', '+92313023634') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '130 days', '2025-12-19'::timestamptz - interval '130 days' + interval '3 days', '2025-12-19'::timestamptz - interval '130 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Dlamini', 'turing.synth.21@example.test', '+92317422869') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '177 days', '2025-12-19'::timestamptz - interval '177 days' + interval '3 days', '2025-12-19'::timestamptz - interval '177 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Khumalo', 'turing.synth.22@example.test', '+92313782622') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '224 days', '2025-12-19'::timestamptz - interval '224 days' + interval '3 days', '2025-12-19'::timestamptz - interval '224 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Mokoena', 'turing.synth.23@example.test', '+92313157799') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '271 days', '2025-12-19'::timestamptz - interval '271 days' + interval '3 days', '2025-12-19'::timestamptz - interval '271 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Ndlovu', 'turing.synth.24@example.test', '+92312068566') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '318 days', '2025-12-19'::timestamptz - interval '318 days' + interval '3 days', '2025-12-19'::timestamptz - interval '318 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Meera', 'Khoza', 'turing.synth.25@example.test', '+92312641764') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '365 days', '2025-12-19'::timestamptz - interval '365 days' + interval '3 days', '2025-12-19'::timestamptz - interval '365 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Mokoena', 'turing.synth.26@example.test', '+92319669308') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '412 days', '2025-12-19'::timestamptz - interval '412 days' + interval '3 days', '2025-12-19'::timestamptz - interval '412 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Rao', 'turing.synth.27@example.test', '+92315077317') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '39 days', '2025-12-19'::timestamptz - interval '39 days' + interval '3 days', '2025-12-19'::timestamptz - interval '39 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Verma', 'turing.synth.28@example.test', '+92315870376') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '86 days', '2025-12-19'::timestamptz - interval '86 days' + interval '3 days', '2025-12-19'::timestamptz - interval '86 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Joshi', 'turing.synth.29@example.test', '+92313160109') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '133 days', '2025-12-19'::timestamptz - interval '133 days' + interval '3 days', '2025-12-19'::timestamptz - interval '133 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Rao', 'turing.synth.30@example.test', '+92319667032') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '180 days', '2025-12-19'::timestamptz - interval '180 days' + interval '3 days', '2025-12-19'::timestamptz - interval '180 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Sharma', 'turing.synth.31@example.test', '+92319653645') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '227 days', '2025-12-19'::timestamptz - interval '227 days' + interval '3 days', '2025-12-19'::timestamptz - interval '227 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Singh', 'turing.synth.32@example.test', '+92311821681') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '274 days', '2025-12-19'::timestamptz - interval '274 days' + interval '3 days', '2025-12-19'::timestamptz - interval '274 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Ndlovu', 'turing.synth.33@example.test', '+92319416044') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '321 days', '2025-12-19'::timestamptz - interval '321 days' + interval '3 days', '2025-12-19'::timestamptz - interval '321 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Kumar', 'turing.synth.34@example.test', '+92314194562') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '368 days', '2025-12-19'::timestamptz - interval '368 days' + interval '3 days', '2025-12-19'::timestamptz - interval '368 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Singh', 'turing.synth.35@example.test', '+92319157361') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '415 days', '2025-12-19'::timestamptz - interval '415 days' + interval '3 days', '2025-12-19'::timestamptz - interval '415 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Menon', 'turing.synth.36@example.test', '+92316728965') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '42 days', '2025-12-19'::timestamptz - interval '42 days' + interval '3 days', '2025-12-19'::timestamptz - interval '42 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Singh', 'turing.synth.37@example.test', '+92313172602') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '89 days', '2025-12-19'::timestamptz - interval '89 days' + interval '3 days', '2025-12-19'::timestamptz - interval '89 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Nair', 'turing.synth.38@example.test', '+92318351767') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '136 days', '2025-12-19'::timestamptz - interval '136 days' + interval '3 days', '2025-12-19'::timestamptz - interval '136 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Gupta', 'turing.synth.39@example.test', '+92313822092') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '183 days', '2025-12-19'::timestamptz - interval '183 days' + interval '3 days', '2025-12-19'::timestamptz - interval '183 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Singh', 'turing.synth.40@example.test', '+92314232853') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '230 days', '2025-12-19'::timestamptz - interval '230 days' + interval '3 days', '2025-12-19'::timestamptz - interval '230 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Patel', 'turing.synth.41@example.test', '+92317073567') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '277 days', '2025-12-19'::timestamptz - interval '277 days' + interval '3 days', '2025-12-19'::timestamptz - interval '277 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Nair', 'turing.synth.42@example.test', '+92315826052') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '324 days', '2025-12-19'::timestamptz - interval '324 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '324 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karan', 'Patel', 'turing.synth.43@example.test', '+92319552235') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '371 days', '2025-12-19'::timestamptz - interval '371 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '371 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Mahlangu', 'turing.synth.44@example.test', '+92316178332') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '418 days', '2025-12-19'::timestamptz - interval '418 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '418 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Patel', 'turing.synth.45@example.test', '+92314658172') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '45 days', '2025-12-19'::timestamptz - interval '45 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Patel', 'turing.synth.46@example.test', '+92315383976') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '92 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ishaan', 'Malhotra', 'turing.synth.47@example.test', '+92317647044') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '139 days', '2025-12-19'::timestamptz - interval '139 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '139 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Nair', 'turing.synth.48@example.test', '+92316312080') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '186 days', '2025-12-19'::timestamptz - interval '186 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '186 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Joshi', 'turing.synth.49@example.test', '+92317772235') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '233 days', '2025-12-19'::timestamptz - interval '233 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '233 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Reddy', 'turing.synth.50@example.test', '+92315837559') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '280 days', '2025-12-19'::timestamptz - interval '280 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Mthembu', 'turing.synth.51@example.test', '+92316424231') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '327 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Ndlovu', 'turing.synth.52@example.test', '+92319200960') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '374 days', '2025-12-19'::timestamptz - interval '374 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '374 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khoza', 'turing.synth.53@example.test', '+92319816630') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '421 days', '2025-12-19'::timestamptz - interval '421 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '421 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Nkosi', 'turing.synth.54@example.test', '+92318419685') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '48 days', '2025-12-19'::timestamptz - interval '48 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '48 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Patel', 'turing.synth.55@example.test', '+92313472000') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '95 days', '2025-12-19'::timestamptz - interval '95 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Khoza', 'turing.synth.56@example.test', '+92317411698') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '142 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mthembu', 'turing.synth.57@example.test', '+92316733137') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '189 days', '2025-12-19'::timestamptz - interval '189 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '189 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Malhotra', 'turing.synth.58@example.test', '+92312724908') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '236 days', '2025-12-19'::timestamptz - interval '236 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '236 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Menon', 'turing.synth.59@example.test', '+92315015974') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '283 days', '2025-12-19'::timestamptz - interval '283 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '283 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Reddy', 'turing.synth.60@example.test', '+92315751549') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '330 days', '2025-12-19'::timestamptz - interval '330 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Verma', 'turing.synth.61@example.test', '+92312895500') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '377 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Khumalo', 'turing.synth.62@example.test', '+92319234093') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '424 days', '2025-12-19'::timestamptz - interval '424 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '424 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Mehta', 'turing.synth.63@example.test', '+92311454987') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '51 days', '2025-12-19'::timestamptz - interval '51 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '51 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Mokoena', 'turing.synth.64@example.test', '+92318762298') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '98 days', '2025-12-19'::timestamptz - interval '98 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '98 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Chauhan', 'turing.synth.65@example.test', '+92315297057') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '145 days', '2025-12-19'::timestamptz - interval '145 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Mahlangu', 'turing.synth.66@example.test', '+92318399630') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '192 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Sithole', 'turing.synth.67@example.test', '+92312077650') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '239 days', '2025-12-19'::timestamptz - interval '239 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '239 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Rao', 'turing.synth.68@example.test', '+92312214143') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '286 days', '2025-12-19'::timestamptz - interval '286 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '286 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Mahlangu', 'turing.synth.69@example.test', '+92313535837') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '333 days', '2025-12-19'::timestamptz - interval '333 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '333 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Nair', 'turing.synth.70@example.test', '+92314013320') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '380 days', '2025-12-19'::timestamptz - interval '380 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Iyer', 'turing.synth.71@example.test', '+92313286657') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '427 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Nkosi', 'turing.synth.72@example.test', '+92319109526') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '54 days', '2025-12-19'::timestamptz - interval '54 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '54 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Nair', 'turing.synth.73@example.test', '+92319365304') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '101 days', '2025-12-19'::timestamptz - interval '101 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '101 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Nair', 'turing.synth.74@example.test', '+92316112726') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '148 days', '2025-12-19'::timestamptz - interval '148 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '148 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Khoza', 'turing.synth.75@example.test', '+92318793671') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '195 days', '2025-12-19'::timestamptz - interval '195 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Chauhan', 'turing.synth.76@example.test', '+92314821708') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '242 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Mehta', 'turing.synth.77@example.test', '+92318156732') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '289 days', '2025-12-19'::timestamptz - interval '289 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '289 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Verma', 'turing.synth.78@example.test', '+92318393793') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '336 days', '2025-12-19'::timestamptz - interval '336 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '336 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Iyer', 'turing.synth.79@example.test', '+92318469122') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '383 days', '2025-12-19'::timestamptz - interval '383 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '383 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Verma', 'turing.synth.80@example.test', '+92315781442') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '430 days', '2025-12-19'::timestamptz - interval '430 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Chauhan', 'turing.synth.81@example.test', '+92316347687') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '57 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Dlamini', 'turing.synth.82@example.test', '+92314089534') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '104 days', '2025-12-19'::timestamptz - interval '104 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '104 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Iyer', 'turing.synth.83@example.test', '+92313285605') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '151 days', '2025-12-19'::timestamptz - interval '151 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '151 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mahlangu', 'turing.synth.84@example.test', '+92317440679') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '198 days', '2025-12-19'::timestamptz - interval '198 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '198 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Menon', 'turing.synth.85@example.test', '+92316038785') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '245 days', '2025-12-19'::timestamptz - interval '245 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ishaan', 'Sharma', 'turing.synth.86@example.test', '+92316960422') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '292 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Reddy', 'turing.synth.87@example.test', '+92316017771') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '339 days', '2025-12-19'::timestamptz - interval '339 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '339 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Singh', 'turing.synth.88@example.test', '+92317776508') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '386 days', '2025-12-19'::timestamptz - interval '386 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '386 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Zulu', 'turing.synth.89@example.test', '+92313804152') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '433 days', '2025-12-19'::timestamptz - interval '433 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '433 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Mokoena', 'turing.synth.90@example.test', '+92312145357') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '60 days', '2025-12-19'::timestamptz - interval '60 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Mthembu', 'turing.synth.91@example.test', '+92314974834') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '107 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Mokoena', 'turing.synth.92@example.test', '+92319334703') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '154 days', '2025-12-19'::timestamptz - interval '154 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '154 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Khoza', 'turing.synth.93@example.test', '+92314551231') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '201 days', '2025-12-19'::timestamptz - interval '201 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '201 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Kumar', 'turing.synth.94@example.test', '+92318467976') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '248 days', '2025-12-19'::timestamptz - interval '248 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '248 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Dlamini', 'turing.synth.95@example.test', '+92313492248') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '295 days', '2025-12-19'::timestamptz - interval '295 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Patel', 'turing.synth.96@example.test', '+92314246320') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '342 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Nkosi', 'turing.synth.97@example.test', '+92311211102') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '389 days', '2025-12-19'::timestamptz - interval '389 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '389 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Malhotra', 'turing.synth.98@example.test', '+92317990731') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '436 days', '2025-12-19'::timestamptz - interval '436 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '436 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Zulu', 'turing.synth.99@example.test', '+92316881394') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '63 days', '2025-12-19'::timestamptz - interval '63 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '63 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Khoza', 'turing.synth.100@example.test', '+92311755971') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '110 days', '2025-12-19'::timestamptz - interval '110 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Dlamini', 'turing.synth.101@example.test', '+92318779653') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '157 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Sithole', 'turing.synth.102@example.test', '+92311915127') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '204 days', '2025-12-19'::timestamptz - interval '204 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '204 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Sithole', 'turing.synth.103@example.test', '+92319932695') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '251 days', '2025-12-19'::timestamptz - interval '251 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '251 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Nair', 'turing.synth.104@example.test', '+92319688280') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '298 days', '2025-12-19'::timestamptz - interval '298 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '298 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Menon', 'turing.synth.105@example.test', '+92316442798') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '345 days', '2025-12-19'::timestamptz - interval '345 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Singh', 'turing.synth.106@example.test', '+92316909023') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '392 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Reddy', 'turing.synth.107@example.test', '+92315838592') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '439 days', '2025-12-19'::timestamptz - interval '439 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '439 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Mehta', 'turing.synth.108@example.test', '+92312148465') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '66 days', '2025-12-19'::timestamptz - interval '66 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '66 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Singh', 'turing.synth.109@example.test', '+92318477987') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '113 days', '2025-12-19'::timestamptz - interval '113 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '113 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Iyer', 'turing.synth.110@example.test', '+92318303299') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '160 days', '2025-12-19'::timestamptz - interval '160 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Dlamini', 'turing.synth.111@example.test', '+92312135202') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '207 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Iyer', 'turing.synth.112@example.test', '+92311170620') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '254 days', '2025-12-19'::timestamptz - interval '254 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '254 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Verma', 'turing.synth.113@example.test', '+92319139375') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '301 days', '2025-12-19'::timestamptz - interval '301 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '301 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Rao', 'turing.synth.114@example.test', '+92312115136') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '348 days', '2025-12-19'::timestamptz - interval '348 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '348 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Mehta', 'turing.synth.115@example.test', '+92319202679') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '395 days', '2025-12-19'::timestamptz - interval '395 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Rao', 'turing.synth.116@example.test', '+92314925290') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '442 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Sithole', 'turing.synth.117@example.test', '+92312037171') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '69 days', '2025-12-19'::timestamptz - interval '69 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '69 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Rao', 'turing.synth.118@example.test', '+92317128440') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '116 days', '2025-12-19'::timestamptz - interval '116 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '116 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Khumalo', 'turing.synth.119@example.test', '+92314055115') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '163 days', '2025-12-19'::timestamptz - interval '163 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '163 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Nair', 'turing.synth.120@example.test', '+92318620855') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '210 days', '2025-12-19'::timestamptz - interval '210 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Khumalo', 'turing.synth.121@example.test', '+92311512235') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '257 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Patel', 'turing.synth.122@example.test', '+92318370128') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '304 days', '2025-12-19'::timestamptz - interval '304 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '304 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Singh', 'turing.synth.123@example.test', '+92313983307') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '351 days', '2025-12-19'::timestamptz - interval '351 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '351 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Joshi', 'turing.synth.124@example.test', '+92311238518') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '398 days', '2025-12-19'::timestamptz - interval '398 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '398 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Sharma', 'turing.synth.125@example.test', '+92313125569') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '445 days', '2025-12-19'::timestamptz - interval '445 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Ndlovu', 'turing.synth.126@example.test', '+92313785323') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '72 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Malhotra', 'turing.synth.127@example.test', '+92317324594') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '119 days', '2025-12-19'::timestamptz - interval '119 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '119 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Khumalo', 'turing.synth.128@example.test', '+92312968399') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '166 days', '2025-12-19'::timestamptz - interval '166 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '166 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Joshi', 'turing.synth.129@example.test', '+92313373836') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '213 days', '2025-12-19'::timestamptz - interval '213 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '213 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena', 'turing.synth.130@example.test', '+92312675622') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '260 days', '2025-12-19'::timestamptz - interval '260 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Mthembu', 'turing.synth.131@example.test', '+92314053954') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '307 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Mthembu', 'turing.synth.132@example.test', '+92314579120') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '354 days', '2025-12-19'::timestamptz - interval '354 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '354 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Patel', 'turing.synth.133@example.test', '+92313146784') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '401 days', '2025-12-19'::timestamptz - interval '401 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '401 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Malhotra', 'turing.synth.134@example.test', '+92316299055') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '448 days', '2025-12-19'::timestamptz - interval '448 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '448 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Iyer', 'turing.synth.135@example.test', '+92312195139') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '75 days', '2025-12-19'::timestamptz - interval '75 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Verma', 'turing.synth.136@example.test', '+92319319969') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '122 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Malhotra', 'turing.synth.137@example.test', '+92318990521') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '169 days', '2025-12-19'::timestamptz - interval '169 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '169 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Patel', 'turing.synth.138@example.test', '+92318372335') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '216 days', '2025-12-19'::timestamptz - interval '216 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '216 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Sithole', 'turing.synth.139@example.test', '+92319529809') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '263 days', '2025-12-19'::timestamptz - interval '263 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '263 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Nkosi', 'turing.synth.140@example.test', '+92318143443') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '310 days', '2025-12-19'::timestamptz - interval '310 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Iyer', 'turing.synth.141@example.test', '+92318954063') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '357 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Mokoena', 'turing.synth.142@example.test', '+92315330241') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '404 days', '2025-12-19'::timestamptz - interval '404 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '404 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Sithole', 'turing.synth.143@example.test', '+92317515481') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '31 days', '2025-12-19'::timestamptz - interval '31 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '31 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Joshi', 'turing.synth.144@example.test', '+92319362432') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '78 days', '2025-12-19'::timestamptz - interval '78 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '78 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Rao', 'turing.synth.145@example.test', '+92313865440') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '125 days', '2025-12-19'::timestamptz - interval '125 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Chauhan', 'turing.synth.146@example.test', '+92315716398') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '172 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Chauhan', 'turing.synth.147@example.test', '+92318917133') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '219 days', '2025-12-19'::timestamptz - interval '219 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '219 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Sithole', 'turing.synth.148@example.test', '+92318059377') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '266 days', '2025-12-19'::timestamptz - interval '266 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '266 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Joshi', 'turing.synth.149@example.test', '+92317635488') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '313 days', '2025-12-19'::timestamptz - interval '313 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '313 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karan', 'Joshi', 'turing.synth.150@example.test', '+92313563361') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '360 days', '2025-12-19'::timestamptz - interval '360 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Dlamini', 'turing.synth.151@example.test', '+92312415844') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '407 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Reddy', 'turing.synth.152@example.test', '+92317269610') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '34 days', '2025-12-19'::timestamptz - interval '34 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '34 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Malhotra', 'turing.synth.153@example.test', '+92317975982') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '81 days', '2025-12-19'::timestamptz - interval '81 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '81 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Sharma', 'turing.synth.154@example.test', '+92318204185') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '128 days', '2025-12-19'::timestamptz - interval '128 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '128 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Patel', 'turing.synth.155@example.test', '+92318926863') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '175 days', '2025-12-19'::timestamptz - interval '175 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Menon', 'turing.synth.156@example.test', '+92311108476') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '222 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Mthembu', 'turing.synth.157@example.test', '+92319379010') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '269 days', '2025-12-19'::timestamptz - interval '269 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '269 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Gupta', 'turing.synth.158@example.test', '+92317230211') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '316 days', '2025-12-19'::timestamptz - interval '316 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '316 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Menon', 'turing.synth.159@example.test', '+92314450320') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '363 days', '2025-12-19'::timestamptz - interval '363 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '363 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Mehta', 'turing.synth.160@example.test', '+92311054387') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '410 days', '2025-12-19'::timestamptz - interval '410 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Sithole', 'turing.synth.161@example.test', '+92314189822') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '37 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Nkosi', 'turing.synth.162@example.test', '+92313076191') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '84 days', '2025-12-19'::timestamptz - interval '84 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '84 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Khumalo', 'turing.synth.163@example.test', '+92312199133') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '131 days', '2025-12-19'::timestamptz - interval '131 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '131 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Gupta', 'turing.synth.164@example.test', '+92317864609') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '178 days', '2025-12-19'::timestamptz - interval '178 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '178 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Chauhan', 'turing.synth.165@example.test', '+92319550444') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '225 days', '2025-12-19'::timestamptz - interval '225 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Nkosi', 'turing.synth.166@example.test', '+92314299038') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '272 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Nkosi', 'turing.synth.167@example.test', '+92318812807') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '319 days', '2025-12-19'::timestamptz - interval '319 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '319 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Singh', 'turing.synth.168@example.test', '+92312056648') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '366 days', '2025-12-19'::timestamptz - interval '366 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '366 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Kumar', 'turing.synth.169@example.test', '+92314466168') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '413 days', '2025-12-19'::timestamptz - interval '413 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '413 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Dlamini', 'turing.synth.170@example.test', '+92318946920') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '40 days', '2025-12-19'::timestamptz - interval '40 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Nkosi', 'turing.synth.171@example.test', '+92317751143') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '87 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Nair', 'turing.synth.172@example.test', '+92314312955') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '134 days', '2025-12-19'::timestamptz - interval '134 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '134 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Mehta', 'turing.synth.173@example.test', '+92316028381') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '181 days', '2025-12-19'::timestamptz - interval '181 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '181 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Joshi', 'turing.synth.174@example.test', '+92311794053') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '228 days', '2025-12-19'::timestamptz - interval '228 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '228 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Dlamini', 'turing.synth.175@example.test', '+92315544482') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '275 days', '2025-12-19'::timestamptz - interval '275 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Chauhan', 'turing.synth.176@example.test', '+92318793343') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '322 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Sithole', 'turing.synth.177@example.test', '+92311646249') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '369 days', '2025-12-19'::timestamptz - interval '369 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '369 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Patel', 'turing.synth.178@example.test', '+92316508609') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '416 days', '2025-12-19'::timestamptz - interval '416 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '416 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Reddy', 'turing.synth.179@example.test', '+92316745016') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '43 days', '2025-12-19'::timestamptz - interval '43 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '43 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Sharma', 'turing.synth.180@example.test', '+92313426717') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '90 days', '2025-12-19'::timestamptz - interval '90 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Menon', 'turing.synth.181@example.test', '+92314152375') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '137 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Mokoena', 'turing.synth.182@example.test', '+92315356064') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '184 days', '2025-12-19'::timestamptz - interval '184 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '184 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Khoza', 'turing.synth.183@example.test', '+92319930164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '231 days', '2025-12-19'::timestamptz - interval '231 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '231 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Reddy', 'turing.synth.184@example.test', '+92316818449') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '278 days', '2025-12-19'::timestamptz - interval '278 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '278 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Dlamini', 'turing.synth.185@example.test', '+92317039075') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '325 days', '2025-12-19'::timestamptz - interval '325 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Rao', 'turing.synth.186@example.test', '+92313763460') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '372 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Mahlangu', 'turing.synth.187@example.test', '+92319121261') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '419 days', '2025-12-19'::timestamptz - interval '419 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '419 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karan', 'Nkosi', 'turing.synth.188@example.test', '+92318083071') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '46 days', '2025-12-19'::timestamptz - interval '46 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '46 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Ndlovu', 'turing.synth.189@example.test', '+92317220958') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '93 days', '2025-12-19'::timestamptz - interval '93 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '93 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Kumar', 'turing.synth.190@example.test', '+92313899049') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '140 days', '2025-12-19'::timestamptz - interval '140 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Mthembu', 'turing.synth.191@example.test', '+92315046921') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '187 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma', 'turing.synth.192@example.test', '+92314228034') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '234 days', '2025-12-19'::timestamptz - interval '234 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '234 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Sharma', 'turing.synth.193@example.test', '+92313456391') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '281 days', '2025-12-19'::timestamptz - interval '281 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '281 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Meera', 'Mahlangu', 'turing.synth.194@example.test', '+92312161670') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '328 days', '2025-12-19'::timestamptz - interval '328 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '328 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Sharma', 'turing.synth.195@example.test', '+92314639613') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '375 days', '2025-12-19'::timestamptz - interval '375 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Menon', 'turing.synth.196@example.test', '+92314790059') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '422 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Sharma', 'turing.synth.197@example.test', '+92311900740') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '49 days', '2025-12-19'::timestamptz - interval '49 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '49 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Malhotra', 'turing.synth.198@example.test', '+92313442713') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '96 days', '2025-12-19'::timestamptz - interval '96 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '96 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Gupta', 'turing.synth.199@example.test', '+92319734587') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '143 days', '2025-12-19'::timestamptz - interval '143 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '143 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Iyer', 'turing.synth.200@example.test', '+92317783623') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '190 days', '2025-12-19'::timestamptz - interval '190 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Menon', 'turing.synth.201@example.test', '+92316343017') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '237 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole', 'turing.synth.202@example.test', '+92319135225') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '284 days', '2025-12-19'::timestamptz - interval '284 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '284 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Khumalo', 'turing.synth.203@example.test', '+92319122497') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '331 days', '2025-12-19'::timestamptz - interval '331 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '331 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Menon', 'turing.synth.204@example.test', '+92317479353') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '378 days', '2025-12-19'::timestamptz - interval '378 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '378 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Mthembu', 'turing.synth.205@example.test', '+92316341977') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '425 days', '2025-12-19'::timestamptz - interval '425 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Singh', 'turing.synth.206@example.test', '+92311957397') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '52 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'Verma', 'turing.synth.207@example.test', '+92314651688') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '99 days', '2025-12-19'::timestamptz - interval '99 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '99 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Dlamini', 'turing.synth.208@example.test', '+92319781093') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '146 days', '2025-12-19'::timestamptz - interval '146 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '146 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Joshi', 'turing.synth.209@example.test', '+92313411998') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '193 days', '2025-12-19'::timestamptz - interval '193 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '193 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Zulu', 'turing.synth.210@example.test', '+92319171860') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '240 days', '2025-12-19'::timestamptz - interval '240 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Dlamini', 'turing.synth.211@example.test', '+92317589772') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '287 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Ndlovu', 'turing.synth.212@example.test', '+92315112881') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '334 days', '2025-12-19'::timestamptz - interval '334 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '334 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Khumalo', 'turing.synth.213@example.test', '+92311223737') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '381 days', '2025-12-19'::timestamptz - interval '381 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '381 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Malhotra', 'turing.synth.214@example.test', '+92315051384') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '428 days', '2025-12-19'::timestamptz - interval '428 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '428 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Kumar', 'turing.synth.215@example.test', '+92317424455') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '55 days', '2025-12-19'::timestamptz - interval '55 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Mthembu', 'turing.synth.216@example.test', '+92311699457') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '102 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Siddharth', 'Iyer', 'turing.synth.217@example.test', '+92311795755') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '149 days', '2025-12-19'::timestamptz - interval '149 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '149 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Singh', 'turing.synth.218@example.test', '+92313076138') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '196 days', '2025-12-19'::timestamptz - interval '196 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '196 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Sharma', 'turing.synth.219@example.test', '+92318422225') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '243 days', '2025-12-19'::timestamptz - interval '243 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '243 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Sharma', 'turing.synth.220@example.test', '+92313805548') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '290 days', '2025-12-19'::timestamptz - interval '290 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Patel', 'turing.synth.221@example.test', '+92316165298') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '337 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Menon', 'turing.synth.222@example.test', '+92312540853') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '384 days', '2025-12-19'::timestamptz - interval '384 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '384 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Kumar', 'turing.synth.223@example.test', '+92319730603') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '431 days', '2025-12-19'::timestamptz - interval '431 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '431 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Gupta', 'turing.synth.224@example.test', '+92314442078') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '58 days', '2025-12-19'::timestamptz - interval '58 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '58 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Nkosi', 'turing.synth.225@example.test', '+92312100435') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '105 days', '2025-12-19'::timestamptz - interval '105 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Patel', 'turing.synth.226@example.test', '+92316293164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '152 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Malhotra', 'turing.synth.227@example.test', '+92316280400') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '199 days', '2025-12-19'::timestamptz - interval '199 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '199 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Sithole', 'turing.synth.228@example.test', '+92315304631') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '246 days', '2025-12-19'::timestamptz - interval '246 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '246 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Chauhan', 'turing.synth.229@example.test', '+92315468234') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '293 days', '2025-12-19'::timestamptz - interval '293 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '293 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Reddy', 'turing.synth.230@example.test', '+92319494324') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '340 days', '2025-12-19'::timestamptz - interval '340 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Chauhan', 'turing.synth.231@example.test', '+92317672358') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '387 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Chauhan', 'turing.synth.232@example.test', '+92315220267') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '434 days', '2025-12-19'::timestamptz - interval '434 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '434 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Rao', 'turing.synth.233@example.test', '+92315266341') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '61 days', '2025-12-19'::timestamptz - interval '61 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '61 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Nkosi', 'turing.synth.234@example.test', '+92318425654') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '108 days', '2025-12-19'::timestamptz - interval '108 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '108 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Kumar', 'turing.synth.235@example.test', '+92311524984') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '155 days', '2025-12-19'::timestamptz - interval '155 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini', 'turing.synth.236@example.test', '+92318595720') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '202 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Mehta', 'turing.synth.237@example.test', '+92316644779') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '249 days', '2025-12-19'::timestamptz - interval '249 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '249 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Khumalo', 'turing.synth.238@example.test', '+92312605130') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '296 days', '2025-12-19'::timestamptz - interval '296 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '296 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Reddy', 'turing.synth.239@example.test', '+92319642732') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '343 days', '2025-12-19'::timestamptz - interval '343 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '343 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karan', 'Malhotra', 'turing.synth.240@example.test', '+92315673910') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '390 days', '2025-12-19'::timestamptz - interval '390 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Menon', 'turing.synth.241@example.test', '+92311945967') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '437 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Sharma', 'turing.synth.242@example.test', '+92318001499') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '64 days', '2025-12-19'::timestamptz - interval '64 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '64 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Mokoena', 'turing.synth.243@example.test', '+92317812549') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '111 days', '2025-12-19'::timestamptz - interval '111 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '111 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Mehta', 'turing.synth.244@example.test', '+92316030469') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '158 days', '2025-12-19'::timestamptz - interval '158 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '158 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mpho', 'Mahlangu', 'turing.synth.245@example.test', '+92315233598') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '205 days', '2025-12-19'::timestamptz - interval '205 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Rao', 'turing.synth.246@example.test', '+92313716294') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '252 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Ndlovu', 'turing.synth.247@example.test', '+92316664288') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '299 days', '2025-12-19'::timestamptz - interval '299 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '299 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Joshi', 'turing.synth.248@example.test', '+92314598393') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '346 days', '2025-12-19'::timestamptz - interval '346 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '346 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Joshi', 'turing.synth.249@example.test', '+92313091393') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '393 days', '2025-12-19'::timestamptz - interval '393 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '393 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Ndlovu', 'turing.synth.250@example.test', '+92312682697') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '440 days', '2025-12-19'::timestamptz - interval '440 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta', 'turing.synth.251@example.test', '+92314461576') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '67 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Mokoena', 'turing.synth.252@example.test', '+92319507921') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '114 days', '2025-12-19'::timestamptz - interval '114 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '114 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anjali', 'Chauhan', 'turing.synth.253@example.test', '+92313402225') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '161 days', '2025-12-19'::timestamptz - interval '161 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '161 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Chauhan', 'turing.synth.254@example.test', '+92316314917') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '208 days', '2025-12-19'::timestamptz - interval '208 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '208 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Zulu', 'turing.synth.255@example.test', '+92316946342') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '255 days', '2025-12-19'::timestamptz - interval '255 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ishaan', 'Patel', 'turing.synth.256@example.test', '+92311932610') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '302 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Khumalo', 'turing.synth.257@example.test', '+92315128809') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '349 days', '2025-12-19'::timestamptz - interval '349 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '349 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Malhotra', 'turing.synth.258@example.test', '+92312721436') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '396 days', '2025-12-19'::timestamptz - interval '396 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '396 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Dlamini', 'turing.synth.259@example.test', '+92313252711') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '443 days', '2025-12-19'::timestamptz - interval '443 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '443 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Rao', 'turing.synth.260@example.test', '+92317396876') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '70 days', '2025-12-19'::timestamptz - interval '70 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Mehta', 'turing.synth.261@example.test', '+92314808384') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '117 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Khoza', 'turing.synth.262@example.test', '+92317225465') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '164 days', '2025-12-19'::timestamptz - interval '164 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '164 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Singh', 'turing.synth.263@example.test', '+92319596816') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '211 days', '2025-12-19'::timestamptz - interval '211 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '211 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Dlamini', 'turing.synth.264@example.test', '+92313559871') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '258 days', '2025-12-19'::timestamptz - interval '258 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '258 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Sithole', 'turing.synth.265@example.test', '+92314662954') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '305 days', '2025-12-19'::timestamptz - interval '305 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Malhotra', 'turing.synth.266@example.test', '+92311496701') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '352 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Sharma', 'turing.synth.267@example.test', '+92311332175') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '399 days', '2025-12-19'::timestamptz - interval '399 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '399 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Patel', 'turing.synth.268@example.test', '+92311557352') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '446 days', '2025-12-19'::timestamptz - interval '446 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '446 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Dlamini', 'turing.synth.269@example.test', '+92311221786') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '73 days', '2025-12-19'::timestamptz - interval '73 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '73 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair', 'turing.synth.270@example.test', '+92313449097') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '120 days', '2025-12-19'::timestamptz - interval '120 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Patel', 'turing.synth.271@example.test', '+92319426902') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '167 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Sharma', 'turing.synth.272@example.test', '+92314643493') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '214 days', '2025-12-19'::timestamptz - interval '214 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '214 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Rao', 'turing.synth.273@example.test', '+92316661007') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '261 days', '2025-12-19'::timestamptz - interval '261 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '261 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Khumalo', 'turing.synth.274@example.test', '+92313096609') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '308 days', '2025-12-19'::timestamptz - interval '308 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '308 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Singh', 'turing.synth.275@example.test', '+92312885606') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '355 days', '2025-12-19'::timestamptz - interval '355 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Nair', 'turing.synth.276@example.test', '+92315866978') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '402 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anjali', 'Verma', 'turing.synth.277@example.test', '+92313344324') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '449 days', '2025-12-19'::timestamptz - interval '449 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '449 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Reddy', 'turing.synth.278@example.test', '+92318138683') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '76 days', '2025-12-19'::timestamptz - interval '76 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '76 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Kumar', 'turing.synth.279@example.test', '+92314886135') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '123 days', '2025-12-19'::timestamptz - interval '123 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '123 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Sharma', 'turing.synth.280@example.test', '+92316912398') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '170 days', '2025-12-19'::timestamptz - interval '170 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Chauhan', 'turing.synth.281@example.test', '+92316915609') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '217 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nkosi', 'turing.synth.282@example.test', '+92316704073') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '264 days', '2025-12-19'::timestamptz - interval '264 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '264 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Zulu', 'turing.synth.283@example.test', '+92315948844') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '311 days', '2025-12-19'::timestamptz - interval '311 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '311 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Zulu', 'turing.synth.284@example.test', '+92315387951') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '358 days', '2025-12-19'::timestamptz - interval '358 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '358 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Khoza', 'turing.synth.285@example.test', '+92318806817') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '405 days', '2025-12-19'::timestamptz - interval '405 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Rao', 'turing.synth.286@example.test', '+92315449632') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '32 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Singh', 'turing.synth.287@example.test', '+92317266096') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '79 days', '2025-12-19'::timestamptz - interval '79 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '79 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Patel', 'turing.synth.288@example.test', '+92312258652') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '126 days', '2025-12-19'::timestamptz - interval '126 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '126 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Kumar', 'turing.synth.289@example.test', '+92312160608') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '173 days', '2025-12-19'::timestamptz - interval '173 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '173 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza', 'turing.synth.290@example.test', '+92315457110') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '220 days', '2025-12-19'::timestamptz - interval '220 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer', 'turing.synth.291@example.test', '+92313492257') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '267 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Sharma', 'turing.synth.292@example.test', '+92316893244') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '314 days', '2025-12-19'::timestamptz - interval '314 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '314 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Mthembu', 'turing.synth.293@example.test', '+92315753999') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '361 days', '2025-12-19'::timestamptz - interval '361 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '361 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ishaan', 'Singh', 'turing.synth.294@example.test', '+92315161974') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '408 days', '2025-12-19'::timestamptz - interval '408 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '408 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Mokoena', 'turing.synth.295@example.test', '+92316998637') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '35 days', '2025-12-19'::timestamptz - interval '35 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Gupta', 'turing.synth.296@example.test', '+92315658424') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '82 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Iyer', 'turing.synth.297@example.test', '+92319050241') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '129 days', '2025-12-19'::timestamptz - interval '129 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '129 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Mokoena', 'turing.synth.298@example.test', '+92316167220') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '176 days', '2025-12-19'::timestamptz - interval '176 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '176 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Reddy', 'turing.synth.299@example.test', '+92318683798') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '223 days', '2025-12-19'::timestamptz - interval '223 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '223 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Dlamini', 'turing.synth.300@example.test', '+92311252464') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '270 days', '2025-12-19'::timestamptz - interval '270 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Dlamini', 'turing.synth.301@example.test', '+92318639393') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '317 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Mehta', 'turing.synth.302@example.test', '+92314818591') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '364 days', '2025-12-19'::timestamptz - interval '364 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '364 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Sharma', 'turing.synth.303@example.test', '+92315329790') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '411 days', '2025-12-19'::timestamptz - interval '411 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '411 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Zulu', 'turing.synth.304@example.test', '+92314120686') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '38 days', '2025-12-19'::timestamptz - interval '38 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '38 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Chauhan', 'turing.synth.305@example.test', '+92316820652') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '85 days', '2025-12-19'::timestamptz - interval '85 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Verma', 'turing.synth.306@example.test', '+92313349040') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '132 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma', 'turing.synth.307@example.test', '+92316846670') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '179 days', '2025-12-19'::timestamptz - interval '179 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '179 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Khoza', 'turing.synth.308@example.test', '+92313838357') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '226 days', '2025-12-19'::timestamptz - interval '226 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '226 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Reddy', 'turing.synth.309@example.test', '+92311767537') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '273 days', '2025-12-19'::timestamptz - interval '273 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '273 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lerato', 'Patel', 'turing.synth.310@example.test', '+92319659246') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '320 days', '2025-12-19'::timestamptz - interval '320 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Singh', 'turing.synth.311@example.test', '+92311529513') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '367 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Singh', 'turing.synth.312@example.test', '+92312899182') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '414 days', '2025-12-19'::timestamptz - interval '414 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '414 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Khumalo', 'turing.synth.313@example.test', '+92319339866') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '41 days', '2025-12-19'::timestamptz - interval '41 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '41 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Sithole', 'turing.synth.314@example.test', '+92318253937') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '88 days', '2025-12-19'::timestamptz - interval '88 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '88 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Sithole', 'turing.synth.315@example.test', '+92316682620') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '135 days', '2025-12-19'::timestamptz - interval '135 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Kumar', 'turing.synth.316@example.test', '+92316480733') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '182 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Menon', 'turing.synth.317@example.test', '+92315382509') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '229 days', '2025-12-19'::timestamptz - interval '229 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '229 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Chauhan', 'turing.synth.318@example.test', '+92313971395') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '276 days', '2025-12-19'::timestamptz - interval '276 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '276 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Mehta', 'turing.synth.319@example.test', '+92313205918') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '323 days', '2025-12-19'::timestamptz - interval '323 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '323 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zanele', 'Mthembu', 'turing.synth.320@example.test', '+92315579640') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '370 days', '2025-12-19'::timestamptz - interval '370 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Kumar', 'turing.synth.321@example.test', '+92317637887') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '417 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Mthembu', 'turing.synth.322@example.test', '+92318912187') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '44 days', '2025-12-19'::timestamptz - interval '44 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '44 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Khoza', 'turing.synth.323@example.test', '+92314117570') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '91 days', '2025-12-19'::timestamptz - interval '91 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '91 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Zulu', 'turing.synth.324@example.test', '+92317577820') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '138 days', '2025-12-19'::timestamptz - interval '138 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '138 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Nkosi', 'turing.synth.325@example.test', '+92315006311') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '185 days', '2025-12-19'::timestamptz - interval '185 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Khoza', 'turing.synth.326@example.test', '+92314814630') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '232 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anjali', 'Khumalo', 'turing.synth.327@example.test', '+92311390995') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '279 days', '2025-12-19'::timestamptz - interval '279 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '279 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Khumalo', 'turing.synth.328@example.test', '+92313195981') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '326 days', '2025-12-19'::timestamptz - interval '326 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '326 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Malhotra', 'turing.synth.329@example.test', '+92317589745') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '373 days', '2025-12-19'::timestamptz - interval '373 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '373 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon', 'turing.synth.330@example.test', '+92313238176') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '420 days', '2025-12-19'::timestamptz - interval '420 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Ndlovu', 'turing.synth.331@example.test', '+92311398296') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '47 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Iyer', 'turing.synth.332@example.test', '+92317407067') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '94 days', '2025-12-19'::timestamptz - interval '94 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '94 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Dlamini', 'turing.synth.333@example.test', '+92317801599') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '141 days', '2025-12-19'::timestamptz - interval '141 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '141 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Mehta', 'turing.synth.334@example.test', '+92311617656') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '188 days', '2025-12-19'::timestamptz - interval '188 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '188 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Verma', 'turing.synth.335@example.test', '+92319174494') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '235 days', '2025-12-19'::timestamptz - interval '235 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ishaan', 'Rao', 'turing.synth.336@example.test', '+92316957818') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '282 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Nair', 'turing.synth.337@example.test', '+92314154261') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '329 days', '2025-12-19'::timestamptz - interval '329 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '329 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Singh', 'turing.synth.338@example.test', '+92318809103') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '376 days', '2025-12-19'::timestamptz - interval '376 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '376 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Joshi', 'turing.synth.339@example.test', '+92314171926') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '423 days', '2025-12-19'::timestamptz - interval '423 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '423 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Khumalo', 'turing.synth.340@example.test', '+92316407678') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '50 days', '2025-12-19'::timestamptz - interval '50 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Mokoena', 'turing.synth.341@example.test', '+92311103772') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '97 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Verma', 'turing.synth.342@example.test', '+92318638998') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '144 days', '2025-12-19'::timestamptz - interval '144 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '144 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nokuthula', 'Nkosi', 'turing.synth.343@example.test', '+92314590119') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '191 days', '2025-12-19'::timestamptz - interval '191 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '191 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Gupta', 'turing.synth.344@example.test', '+92315678576') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '238 days', '2025-12-19'::timestamptz - interval '238 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '238 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Mthembu', 'turing.synth.345@example.test', '+92317275624') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '285 days', '2025-12-19'::timestamptz - interval '285 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Dlamini', 'turing.synth.346@example.test', '+92317922164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '332 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Chauhan', 'turing.synth.347@example.test', '+92315466621') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '379 days', '2025-12-19'::timestamptz - interval '379 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '379 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Meera', 'Malhotra', 'turing.synth.348@example.test', '+92313066986') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '426 days', '2025-12-19'::timestamptz - interval '426 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '426 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karabo', 'Gupta', 'turing.synth.349@example.test', '+92318419251') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '53 days', '2025-12-19'::timestamptz - interval '53 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '53 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anjali', 'Mokoena', 'turing.synth.350@example.test', '+92313409353') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '100 days', '2025-12-19'::timestamptz - interval '100 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Verma', 'turing.synth.351@example.test', '+92313097958') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '147 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tshepo', 'Verma', 'turing.synth.352@example.test', '+92311214788') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '194 days', '2025-12-19'::timestamptz - interval '194 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '194 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Rao', 'turing.synth.353@example.test', '+92316454092') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '241 days', '2025-12-19'::timestamptz - interval '241 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '241 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Pooja', 'Iyer', 'turing.synth.354@example.test', '+92316759811') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '288 days', '2025-12-19'::timestamptz - interval '288 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '288 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Ndlovu', 'turing.synth.355@example.test', '+92318886605') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '335 days', '2025-12-19'::timestamptz - interval '335 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Mahlangu', 'turing.synth.356@example.test', '+92311786079') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '382 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Verma', 'turing.synth.357@example.test', '+92314006716') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '429 days', '2025-12-19'::timestamptz - interval '429 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '429 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez', 'marcor.synth.0@example.test', '+92319084476') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '30 days', '2025-12-19'::timestamptz - interval '30 days' + interval '3 days', '2025-12-19'::timestamptz - interval '30 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anna', 'Dubois', 'marcor.synth.1@example.test', '+92311822304') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '77 days', '2025-12-19'::timestamptz - interval '77 days' + interval '3 days', '2025-12-19'::timestamptz - interval '77 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Javier', 'Johnson', 'marcor.synth.2@example.test', '+92317374367') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '124 days', '2025-12-19'::timestamptz - interval '124 days' + interval '3 days', '2025-12-19'::timestamptz - interval '124 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Fernandez', 'marcor.synth.3@example.test', '+92316623343') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '171 days', '2025-12-19'::timestamptz - interval '171 days' + interval '3 days', '2025-12-19'::timestamptz - interval '171 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Sanchez', 'marcor.synth.4@example.test', '+92311040720') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '218 days', '2025-12-19'::timestamptz - interval '218 days' + interval '3 days', '2025-12-19'::timestamptz - interval '218 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Sanchez', 'marcor.synth.5@example.test', '+92319961674') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '265 days', '2025-12-19'::timestamptz - interval '265 days' + interval '3 days', '2025-12-19'::timestamptz - interval '265 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Erik', 'Silva', 'marcor.synth.6@example.test', '+92316822971') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '312 days', '2025-12-19'::timestamptz - interval '312 days' + interval '3 days', '2025-12-19'::timestamptz - interval '312 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Sanchez', 'marcor.synth.7@example.test', '+92319960731') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '359 days', '2025-12-19'::timestamptz - interval '359 days' + interval '3 days', '2025-12-19'::timestamptz - interval '359 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Garcia', 'marcor.synth.8@example.test', '+92312369578') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '406 days', '2025-12-19'::timestamptz - interval '406 days' + interval '3 days', '2025-12-19'::timestamptz - interval '406 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Silva', 'marcor.synth.9@example.test', '+92312240596') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '33 days', '2025-12-19'::timestamptz - interval '33 days' + interval '3 days', '2025-12-19'::timestamptz - interval '33 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Sanchez', 'marcor.synth.10@example.test', '+92311443212') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '80 days', '2025-12-19'::timestamptz - interval '80 days' + interval '3 days', '2025-12-19'::timestamptz - interval '80 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Isabella', 'Sanchez', 'marcor.synth.11@example.test', '+92313020473') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '127 days', '2025-12-19'::timestamptz - interval '127 days' + interval '3 days', '2025-12-19'::timestamptz - interval '127 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Miller', 'marcor.synth.12@example.test', '+92319696398') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '174 days', '2025-12-19'::timestamptz - interval '174 days' + interval '3 days', '2025-12-19'::timestamptz - interval '174 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Dubois', 'marcor.synth.13@example.test', '+92311238536') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '221 days', '2025-12-19'::timestamptz - interval '221 days' + interval '3 days', '2025-12-19'::timestamptz - interval '221 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Daniela', 'Rodriguez', 'marcor.synth.14@example.test', '+92312950237') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '268 days', '2025-12-19'::timestamptz - interval '268 days' + interval '3 days', '2025-12-19'::timestamptz - interval '268 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Gonzalez', 'marcor.synth.15@example.test', '+92313595726') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '315 days', '2025-12-19'::timestamptz - interval '315 days' + interval '3 days', '2025-12-19'::timestamptz - interval '315 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Cruz', 'marcor.synth.16@example.test', '+92319885560') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '362 days', '2025-12-19'::timestamptz - interval '362 days' + interval '3 days', '2025-12-19'::timestamptz - interval '362 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Paula', 'Dubois', 'marcor.synth.17@example.test', '+92316324798') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '409 days', '2025-12-19'::timestamptz - interval '409 days' + interval '3 days', '2025-12-19'::timestamptz - interval '409 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Johnson', 'marcor.synth.18@example.test', '+92312020001') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '36 days', '2025-12-19'::timestamptz - interval '36 days' + interval '3 days', '2025-12-19'::timestamptz - interval '36 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Weber', 'marcor.synth.19@example.test', '+92316998450') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '83 days', '2025-12-19'::timestamptz - interval '83 days' + interval '3 days', '2025-12-19'::timestamptz - interval '83 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Martinez', 'marcor.synth.20@example.test', '+92319542533') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '130 days', '2025-12-19'::timestamptz - interval '130 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '130 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Gonzalez', 'marcor.synth.21@example.test', '+92317357442') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '177 days', '2025-12-19'::timestamptz - interval '177 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '177 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Dubois', 'marcor.synth.22@example.test', '+92319293489') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '224 days', '2025-12-19'::timestamptz - interval '224 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '224 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emma', 'Cruz', 'marcor.synth.23@example.test', '+92314816321') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '271 days', '2025-12-19'::timestamptz - interval '271 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Wilson', 'marcor.synth.24@example.test', '+92311129890') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '318 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Andres', 'Sanchez', 'marcor.synth.25@example.test', '+92312484457') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '365 days', '2025-12-19'::timestamptz - interval '365 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '365 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Vargas', 'marcor.synth.26@example.test', '+92317882843') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '412 days', '2025-12-19'::timestamptz - interval '412 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '412 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Wilson', 'marcor.synth.27@example.test', '+92317484949') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '39 days', '2025-12-19'::timestamptz - interval '39 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '39 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Johnson', 'marcor.synth.28@example.test', '+92316292587') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '86 days', '2025-12-19'::timestamptz - interval '86 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez', 'marcor.synth.29@example.test', '+92318356211') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '133 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Cruz', 'marcor.synth.30@example.test', '+92314163180') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '180 days', '2025-12-19'::timestamptz - interval '180 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '180 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Rodriguez', 'marcor.synth.31@example.test', '+92318349760') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '227 days', '2025-12-19'::timestamptz - interval '227 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '227 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Wilson', 'marcor.synth.32@example.test', '+92317601184') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '274 days', '2025-12-19'::timestamptz - interval '274 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '274 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Fernandez', 'marcor.synth.33@example.test', '+92314421863') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '321 days', '2025-12-19'::timestamptz - interval '321 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Flores', 'marcor.synth.34@example.test', '+92319237061') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '368 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Vargas', 'marcor.synth.35@example.test', '+92314238933') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '415 days', '2025-12-19'::timestamptz - interval '415 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '415 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Rodriguez', 'marcor.synth.36@example.test', '+92315691611') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '42 days', '2025-12-19'::timestamptz - interval '42 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '42 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rossi', 'marcor.synth.37@example.test', '+92314928880') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '89 days', '2025-12-19'::timestamptz - interval '89 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '89 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Muller', 'marcor.synth.38@example.test', '+92311839530') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '136 days', '2025-12-19'::timestamptz - interval '136 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Lopez', 'marcor.synth.39@example.test', '+92318968130') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '183 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Fernandez', 'marcor.synth.40@example.test', '+92313236937') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '230 days', '2025-12-19'::timestamptz - interval '230 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '230 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Rossi', 'marcor.synth.41@example.test', '+92314605388') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '277 days', '2025-12-19'::timestamptz - interval '277 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '277 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Johnson', 'marcor.synth.42@example.test', '+92317050336') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '324 days', '2025-12-19'::timestamptz - interval '324 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '324 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fernanda', 'Vargas', 'marcor.synth.43@example.test', '+92319018746') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '371 days', '2025-12-19'::timestamptz - interval '371 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mateo', 'Flores', 'marcor.synth.44@example.test', '+92311482339') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '418 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Wilson', 'marcor.synth.45@example.test', '+92314136685') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '45 days', '2025-12-19'::timestamptz - interval '45 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '45 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Vargas', 'marcor.synth.46@example.test', '+92314430923') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '92 days', '2025-12-19'::timestamptz - interval '92 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '92 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Andres', 'Dubois', 'marcor.synth.47@example.test', '+92318385204') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '139 days', '2025-12-19'::timestamptz - interval '139 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '139 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Johnson', 'marcor.synth.48@example.test', '+92316172312') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '186 days', '2025-12-19'::timestamptz - interval '186 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Brown', 'marcor.synth.49@example.test', '+92313715864') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '233 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rodriguez', 'marcor.synth.50@example.test', '+92315227384') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '280 days', '2025-12-19'::timestamptz - interval '280 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '280 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Castro', 'marcor.synth.51@example.test', '+92311949464') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '327 days', '2025-12-19'::timestamptz - interval '327 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '327 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Cruz', 'marcor.synth.52@example.test', '+92314921759') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '374 days', '2025-12-19'::timestamptz - interval '374 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '374 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Molina', 'marcor.synth.53@example.test', '+92317889717') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '421 days', '2025-12-19'::timestamptz - interval '421 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Rodriguez', 'marcor.synth.54@example.test', '+92315361308') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '48 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Paula', 'Miller', 'marcor.synth.55@example.test', '+92316217451') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '95 days', '2025-12-19'::timestamptz - interval '95 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '95 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Martinez', 'marcor.synth.56@example.test', '+92318477259') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '142 days', '2025-12-19'::timestamptz - interval '142 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '142 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Garcia', 'marcor.synth.57@example.test', '+92319072626') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '189 days', '2025-12-19'::timestamptz - interval '189 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '189 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Sanchez', 'marcor.synth.58@example.test', '+92318669130') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '236 days', '2025-12-19'::timestamptz - interval '236 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Miller', 'marcor.synth.59@example.test', '+92317712083') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '283 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Miller', 'marcor.synth.60@example.test', '+92318572974') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '330 days', '2025-12-19'::timestamptz - interval '330 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '330 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Gonzalez', 'marcor.synth.61@example.test', '+92316643968') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '377 days', '2025-12-19'::timestamptz - interval '377 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '377 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Dubois', 'marcor.synth.62@example.test', '+92318953778') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '424 days', '2025-12-19'::timestamptz - interval '424 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '424 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Molina', 'marcor.synth.63@example.test', '+92312220317') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '51 days', '2025-12-19'::timestamptz - interval '51 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Rossi', 'marcor.synth.64@example.test', '+92311501184') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '98 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Silva', 'marcor.synth.65@example.test', '+92317183743') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '145 days', '2025-12-19'::timestamptz - interval '145 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '145 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Lopez', 'marcor.synth.66@example.test', '+92316164542') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '192 days', '2025-12-19'::timestamptz - interval '192 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '192 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Johnson', 'marcor.synth.67@example.test', '+92317269172') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '239 days', '2025-12-19'::timestamptz - interval '239 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '239 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Rossi', 'marcor.synth.68@example.test', '+92316272959') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '286 days', '2025-12-19'::timestamptz - interval '286 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Brown', 'marcor.synth.69@example.test', '+92312369540') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '333 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Perez', 'marcor.synth.70@example.test', '+92315658029') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '380 days', '2025-12-19'::timestamptz - interval '380 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '380 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Sanchez', 'marcor.synth.71@example.test', '+92314750839') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '427 days', '2025-12-19'::timestamptz - interval '427 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '427 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Miller', 'marcor.synth.72@example.test', '+92317526187') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '54 days', '2025-12-19'::timestamptz - interval '54 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '54 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Gonzalez', 'marcor.synth.73@example.test', '+92312070150') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '101 days', '2025-12-19'::timestamptz - interval '101 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Silva', 'marcor.synth.74@example.test', '+92316452194') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '148 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Dubois', 'marcor.synth.75@example.test', '+92317173122') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '195 days', '2025-12-19'::timestamptz - interval '195 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '195 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Johnson', 'marcor.synth.76@example.test', '+92319312414') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '242 days', '2025-12-19'::timestamptz - interval '242 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '242 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jessica', 'Sanchez', 'marcor.synth.77@example.test', '+92317871639') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '289 days', '2025-12-19'::timestamptz - interval '289 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '289 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Ortiz', 'marcor.synth.78@example.test', '+92316609014') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '336 days', '2025-12-19'::timestamptz - interval '336 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Dubois', 'marcor.synth.79@example.test', '+92314855537') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '383 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen', 'micro1.synth.0@example.test', '+92314225015') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '30 days', '2025-12-19'::timestamptz - interval '30 days' + interval '3 days', '2025-12-19'::timestamptz - interval '30 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Wong', 'micro1.synth.1@example.test', '+92318472466') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '77 days', '2025-12-19'::timestamptz - interval '77 days' + interval '3 days', '2025-12-19'::timestamptz - interval '77 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Nguyen', 'micro1.synth.2@example.test', '+92312363395') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '124 days', '2025-12-19'::timestamptz - interval '124 days' + interval '3 days', '2025-12-19'::timestamptz - interval '124 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Hassan', 'micro1.synth.3@example.test', '+92316707436') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '171 days', '2025-12-19'::timestamptz - interval '171 days' + interval '3 days', '2025-12-19'::timestamptz - interval '171 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amara', 'Al-Rashid', 'micro1.synth.4@example.test', '+92319213375') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '218 days', '2025-12-19'::timestamptz - interval '218 days' + interval '3 days', '2025-12-19'::timestamptz - interval '218 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Al-Rashid', 'micro1.synth.5@example.test', '+92313703197') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '265 days', '2025-12-19'::timestamptz - interval '265 days' + interval '3 days', '2025-12-19'::timestamptz - interval '265 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Mensah', 'micro1.synth.6@example.test', '+92318786097') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '312 days', '2025-12-19'::timestamptz - interval '312 days' + interval '3 days', '2025-12-19'::timestamptz - interval '312 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ibrahim', 'Rossi', 'micro1.synth.7@example.test', '+92318966626') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '359 days', '2025-12-19'::timestamptz - interval '359 days' + interval '3 days', '2025-12-19'::timestamptz - interval '359 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Kato', 'micro1.synth.8@example.test', '+92313478934') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '406 days', '2025-12-19'::timestamptz - interval '406 days' + interval '3 days', '2025-12-19'::timestamptz - interval '406 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Kato', 'micro1.synth.9@example.test', '+92316715124') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '33 days', '2025-12-19'::timestamptz - interval '33 days' + interval '3 days', '2025-12-19'::timestamptz - interval '33 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Chen', 'micro1.synth.10@example.test', '+92314395968') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '80 days', '2025-12-19'::timestamptz - interval '80 days' + interval '3 days', '2025-12-19'::timestamptz - interval '80 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ngozi', 'Wong', 'micro1.synth.11@example.test', '+92312385636') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '127 days', '2025-12-19'::timestamptz - interval '127 days' + interval '3 days', '2025-12-19'::timestamptz - interval '127 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Osei', 'micro1.synth.12@example.test', '+92318460678') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '174 days', '2025-12-19'::timestamptz - interval '174 days' + interval '3 days', '2025-12-19'::timestamptz - interval '174 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Wong', 'micro1.synth.13@example.test', '+92318552711') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '221 days', '2025-12-19'::timestamptz - interval '221 days' + interval '3 days', '2025-12-19'::timestamptz - interval '221 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anh', 'Suzuki', 'micro1.synth.14@example.test', '+92314277716') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '268 days', '2025-12-19'::timestamptz - interval '268 days' + interval '3 days', '2025-12-19'::timestamptz - interval '268 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Rodriguez', 'micro1.synth.15@example.test', '+92312930267') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '315 days', '2025-12-19'::timestamptz - interval '315 days' + interval '3 days', '2025-12-19'::timestamptz - interval '315 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amara', 'Okafor', 'micro1.synth.16@example.test', '+92317414176') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '362 days', '2025-12-19'::timestamptz - interval '362 days' + interval '3 days', '2025-12-19'::timestamptz - interval '362 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Chen', 'micro1.synth.17@example.test', '+92314176306') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '409 days', '2025-12-19'::timestamptz - interval '409 days' + interval '3 days', '2025-12-19'::timestamptz - interval '409 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Nguyen', 'micro1.synth.18@example.test', '+92314380616') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '36 days', '2025-12-19'::timestamptz - interval '36 days' + interval '3 days', '2025-12-19'::timestamptz - interval '36 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Tran', 'micro1.synth.19@example.test', '+92311036866') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '83 days', '2025-12-19'::timestamptz - interval '83 days' + interval '3 days', '2025-12-19'::timestamptz - interval '83 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Osei', 'micro1.synth.20@example.test', '+92312792018') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '130 days', '2025-12-19'::timestamptz - interval '130 days' + interval '3 days', '2025-12-19'::timestamptz - interval '130 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Tanaka', 'micro1.synth.21@example.test', '+92313886149') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '177 days', '2025-12-19'::timestamptz - interval '177 days' + interval '3 days', '2025-12-19'::timestamptz - interval '177 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Nguyen', 'micro1.synth.22@example.test', '+92319769510') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '224 days', '2025-12-19'::timestamptz - interval '224 days' + interval '3 days', '2025-12-19'::timestamptz - interval '224 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Rossi', 'micro1.synth.23@example.test', '+92316691869') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '271 days', '2025-12-19'::timestamptz - interval '271 days' + interval '3 days', '2025-12-19'::timestamptz - interval '271 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Al-Sayed', 'micro1.synth.24@example.test', '+92311415583') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '318 days', '2025-12-19'::timestamptz - interval '318 days' + interval '3 days', '2025-12-19'::timestamptz - interval '318 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Minjun', 'Muller', 'micro1.synth.25@example.test', '+92318572963') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '365 days', '2025-12-19'::timestamptz - interval '365 days' + interval '3 days', '2025-12-19'::timestamptz - interval '365 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Al-Sayed', 'micro1.synth.26@example.test', '+92312228631') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '412 days', '2025-12-19'::timestamptz - interval '412 days' + interval '3 days', '2025-12-19'::timestamptz - interval '412 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Kato', 'micro1.synth.27@example.test', '+92318373945') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '39 days', '2025-12-19'::timestamptz - interval '39 days' + interval '3 days', '2025-12-19'::timestamptz - interval '39 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Osei', 'micro1.synth.28@example.test', '+92319267198') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '86 days', '2025-12-19'::timestamptz - interval '86 days' + interval '3 days', '2025-12-19'::timestamptz - interval '86 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Kato', 'micro1.synth.29@example.test', '+92318436807') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '133 days', '2025-12-19'::timestamptz - interval '133 days' + interval '3 days', '2025-12-19'::timestamptz - interval '133 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Suzuki', 'micro1.synth.30@example.test', '+92314927958') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '180 days', '2025-12-19'::timestamptz - interval '180 days' + interval '3 days', '2025-12-19'::timestamptz - interval '180 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Rashid', 'micro1.synth.31@example.test', '+92315067561') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '227 days', '2025-12-19'::timestamptz - interval '227 days' + interval '3 days', '2025-12-19'::timestamptz - interval '227 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Kim', 'micro1.synth.32@example.test', '+92315200900') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '274 days', '2025-12-19'::timestamptz - interval '274 days' + interval '3 days', '2025-12-19'::timestamptz - interval '274 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Davis', 'micro1.synth.33@example.test', '+92312436994') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '321 days', '2025-12-19'::timestamptz - interval '321 days' + interval '3 days', '2025-12-19'::timestamptz - interval '321 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Rossi', 'micro1.synth.34@example.test', '+92313026364') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '368 days', '2025-12-19'::timestamptz - interval '368 days' + interval '3 days', '2025-12-19'::timestamptz - interval '368 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Okafor', 'micro1.synth.35@example.test', '+92315287199') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '415 days', '2025-12-19'::timestamptz - interval '415 days' + interval '3 days', '2025-12-19'::timestamptz - interval '415 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Wong', 'micro1.synth.36@example.test', '+92315460148') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '42 days', '2025-12-19'::timestamptz - interval '42 days' + interval '3 days', '2025-12-19'::timestamptz - interval '42 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Ibrahim', 'micro1.synth.37@example.test', '+92317167667') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '89 days', '2025-12-19'::timestamptz - interval '89 days' + interval '3 days', '2025-12-19'::timestamptz - interval '89 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Lopez', 'micro1.synth.38@example.test', '+92316111805') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '136 days', '2025-12-19'::timestamptz - interval '136 days' + interval '3 days', '2025-12-19'::timestamptz - interval '136 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Kim', 'micro1.synth.39@example.test', '+92315423929') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '183 days', '2025-12-19'::timestamptz - interval '183 days' + interval '3 days', '2025-12-19'::timestamptz - interval '183 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Fernandez', 'micro1.synth.40@example.test', '+92313619323') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '230 days', '2025-12-19'::timestamptz - interval '230 days' + interval '3 days', '2025-12-19'::timestamptz - interval '230 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Park', 'micro1.synth.41@example.test', '+92317644876') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '277 days', '2025-12-19'::timestamptz - interval '277 days' + interval '3 days', '2025-12-19'::timestamptz - interval '277 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Rossi', 'micro1.synth.42@example.test', '+92319005629') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '324 days', '2025-12-19'::timestamptz - interval '324 days' + interval '3 days', '2025-12-19'::timestamptz - interval '324 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Seo-yeon', 'Wong', 'micro1.synth.43@example.test', '+92317298659') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '371 days', '2025-12-19'::timestamptz - interval '371 days' + interval '3 days', '2025-12-19'::timestamptz - interval '371 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Rossi', 'micro1.synth.44@example.test', '+92315386097') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '418 days', '2025-12-19'::timestamptz - interval '418 days' + interval '3 days', '2025-12-19'::timestamptz - interval '418 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Wong', 'micro1.synth.45@example.test', '+92316336233') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '45 days', '2025-12-19'::timestamptz - interval '45 days' + interval '3 days', '2025-12-19'::timestamptz - interval '45 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Al-Rashid', 'micro1.synth.46@example.test', '+92316317400') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '92 days', '2025-12-19'::timestamptz - interval '92 days' + interval '3 days', '2025-12-19'::timestamptz - interval '92 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sakura', 'Suzuki', 'micro1.synth.47@example.test', '+92316394969') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '139 days', '2025-12-19'::timestamptz - interval '139 days' + interval '3 days', '2025-12-19'::timestamptz - interval '139 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Al-Rashid', 'micro1.synth.48@example.test', '+92317487791') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '186 days', '2025-12-19'::timestamptz - interval '186 days' + interval '3 days', '2025-12-19'::timestamptz - interval '186 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Yamamoto', 'micro1.synth.49@example.test', '+92316641592') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '233 days', '2025-12-19'::timestamptz - interval '233 days' + interval '3 days', '2025-12-19'::timestamptz - interval '233 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Chen', 'micro1.synth.50@example.test', '+92318532472') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '280 days', '2025-12-19'::timestamptz - interval '280 days' + interval '3 days', '2025-12-19'::timestamptz - interval '280 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Hassan', 'micro1.synth.51@example.test', '+92318254525') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '327 days', '2025-12-19'::timestamptz - interval '327 days' + interval '3 days', '2025-12-19'::timestamptz - interval '327 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Mensah', 'micro1.synth.52@example.test', '+92319576663') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '374 days', '2025-12-19'::timestamptz - interval '374 days' + interval '3 days', '2025-12-19'::timestamptz - interval '374 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Rodriguez', 'micro1.synth.53@example.test', '+92319534637') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '421 days', '2025-12-19'::timestamptz - interval '421 days' + interval '3 days', '2025-12-19'::timestamptz - interval '421 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Kato', 'micro1.synth.54@example.test', '+92316154313') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '48 days', '2025-12-19'::timestamptz - interval '48 days' + interval '3 days', '2025-12-19'::timestamptz - interval '48 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Lopez', 'micro1.synth.55@example.test', '+92315392790') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '95 days', '2025-12-19'::timestamptz - interval '95 days' + interval '3 days', '2025-12-19'::timestamptz - interval '95 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Muller', 'micro1.synth.56@example.test', '+92317009029') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '142 days', '2025-12-19'::timestamptz - interval '142 days' + interval '3 days', '2025-12-19'::timestamptz - interval '142 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Al-Sayed', 'micro1.synth.57@example.test', '+92311267622') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '189 days', '2025-12-19'::timestamptz - interval '189 days' + interval '3 days', '2025-12-19'::timestamptz - interval '189 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Suzuki', 'micro1.synth.58@example.test', '+92314702811') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '236 days', '2025-12-19'::timestamptz - interval '236 days' + interval '3 days', '2025-12-19'::timestamptz - interval '236 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Nguyen', 'micro1.synth.59@example.test', '+92318554224') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '283 days', '2025-12-19'::timestamptz - interval '283 days' + interval '3 days', '2025-12-19'::timestamptz - interval '283 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Rossi', 'micro1.synth.60@example.test', '+92314369039') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '330 days', '2025-12-19'::timestamptz - interval '330 days' + interval '3 days', '2025-12-19'::timestamptz - interval '330 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Lin', 'micro1.synth.61@example.test', '+92318349662') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '377 days', '2025-12-19'::timestamptz - interval '377 days' + interval '3 days', '2025-12-19'::timestamptz - interval '377 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Mensah', 'micro1.synth.62@example.test', '+92313490850') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '424 days', '2025-12-19'::timestamptz - interval '424 days' + interval '3 days', '2025-12-19'::timestamptz - interval '424 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Ibrahim', 'micro1.synth.63@example.test', '+92312738513') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '51 days', '2025-12-19'::timestamptz - interval '51 days' + interval '3 days', '2025-12-19'::timestamptz - interval '51 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Tran', 'micro1.synth.64@example.test', '+92312038732') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '98 days', '2025-12-19'::timestamptz - interval '98 days' + interval '3 days', '2025-12-19'::timestamptz - interval '98 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ibrahim', 'Al-Rashid', 'micro1.synth.65@example.test', '+92317368164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '145 days', '2025-12-19'::timestamptz - interval '145 days' + interval '3 days', '2025-12-19'::timestamptz - interval '145 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Suzuki', 'micro1.synth.66@example.test', '+92317863493') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '192 days', '2025-12-19'::timestamptz - interval '192 days' + interval '3 days', '2025-12-19'::timestamptz - interval '192 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Kato', 'micro1.synth.67@example.test', '+92312585152') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '239 days', '2025-12-19'::timestamptz - interval '239 days' + interval '3 days', '2025-12-19'::timestamptz - interval '239 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Yamamoto', 'micro1.synth.68@example.test', '+92319332090') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '286 days', '2025-12-19'::timestamptz - interval '286 days' + interval '3 days', '2025-12-19'::timestamptz - interval '286 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Lin', 'micro1.synth.69@example.test', '+92318930165') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '333 days', '2025-12-19'::timestamptz - interval '333 days' + interval '3 days', '2025-12-19'::timestamptz - interval '333 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Fernandez', 'micro1.synth.70@example.test', '+92312876487') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '380 days', '2025-12-19'::timestamptz - interval '380 days' + interval '3 days', '2025-12-19'::timestamptz - interval '380 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Al-Sayed', 'micro1.synth.71@example.test', '+92317544293') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '427 days', '2025-12-19'::timestamptz - interval '427 days' + interval '3 days', '2025-12-19'::timestamptz - interval '427 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Suzuki', 'micro1.synth.72@example.test', '+92314481587') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '54 days', '2025-12-19'::timestamptz - interval '54 days' + interval '3 days', '2025-12-19'::timestamptz - interval '54 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Ibrahim', 'micro1.synth.73@example.test', '+92312541934') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '101 days', '2025-12-19'::timestamptz - interval '101 days' + interval '3 days', '2025-12-19'::timestamptz - interval '101 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei', 'micro1.synth.74@example.test', '+92315164150') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '148 days', '2025-12-19'::timestamptz - interval '148 days' + interval '3 days', '2025-12-19'::timestamptz - interval '148 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Al-Sayed', 'micro1.synth.75@example.test', '+92312680561') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '195 days', '2025-12-19'::timestamptz - interval '195 days' + interval '3 days', '2025-12-19'::timestamptz - interval '195 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Nguyen', 'micro1.synth.76@example.test', '+92317980329') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '242 days', '2025-12-19'::timestamptz - interval '242 days' + interval '3 days', '2025-12-19'::timestamptz - interval '242 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Muller', 'micro1.synth.77@example.test', '+92317463329') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '289 days', '2025-12-19'::timestamptz - interval '289 days' + interval '3 days', '2025-12-19'::timestamptz - interval '289 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Al-Sayed', 'micro1.synth.78@example.test', '+92313780149') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '336 days', '2025-12-19'::timestamptz - interval '336 days' + interval '3 days', '2025-12-19'::timestamptz - interval '336 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Chen', 'micro1.synth.79@example.test', '+92318534550') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '383 days', '2025-12-19'::timestamptz - interval '383 days' + interval '3 days', '2025-12-19'::timestamptz - interval '383 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Al-Rashid', 'micro1.synth.80@example.test', '+92311220844') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '430 days', '2025-12-19'::timestamptz - interval '430 days' + interval '3 days', '2025-12-19'::timestamptz - interval '430 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Lopez', 'micro1.synth.81@example.test', '+92312975572') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '57 days', '2025-12-19'::timestamptz - interval '57 days' + interval '3 days', '2025-12-19'::timestamptz - interval '57 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kwame', 'Okafor', 'micro1.synth.82@example.test', '+92311268609') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '104 days', '2025-12-19'::timestamptz - interval '104 days' + interval '3 days', '2025-12-19'::timestamptz - interval '104 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Lin', 'micro1.synth.83@example.test', '+92316637332') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '151 days', '2025-12-19'::timestamptz - interval '151 days' + interval '3 days', '2025-12-19'::timestamptz - interval '151 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Muller', 'micro1.synth.84@example.test', '+92314563945') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '198 days', '2025-12-19'::timestamptz - interval '198 days' + interval '3 days', '2025-12-19'::timestamptz - interval '198 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Rossi', 'micro1.synth.85@example.test', '+92314348734') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '245 days', '2025-12-19'::timestamptz - interval '245 days' + interval '3 days', '2025-12-19'::timestamptz - interval '245 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sakura', 'Osei', 'micro1.synth.86@example.test', '+92311451640') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '292 days', '2025-12-19'::timestamptz - interval '292 days' + interval '3 days', '2025-12-19'::timestamptz - interval '292 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Kim', 'micro1.synth.87@example.test', '+92313898684') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '339 days', '2025-12-19'::timestamptz - interval '339 days' + interval '3 days', '2025-12-19'::timestamptz - interval '339 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Mensah', 'micro1.synth.88@example.test', '+92318068161') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '386 days', '2025-12-19'::timestamptz - interval '386 days' + interval '3 days', '2025-12-19'::timestamptz - interval '386 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Hassan', 'micro1.synth.89@example.test', '+92318639490') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '433 days', '2025-12-19'::timestamptz - interval '433 days' + interval '3 days', '2025-12-19'::timestamptz - interval '433 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Abara', 'micro1.synth.90@example.test', '+92313480798') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '60 days', '2025-12-19'::timestamptz - interval '60 days' + interval '3 days', '2025-12-19'::timestamptz - interval '60 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Kato', 'micro1.synth.91@example.test', '+92318477043') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '107 days', '2025-12-19'::timestamptz - interval '107 days' + interval '3 days', '2025-12-19'::timestamptz - interval '107 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Nguyen', 'micro1.synth.92@example.test', '+92317538284') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '154 days', '2025-12-19'::timestamptz - interval '154 days' + interval '3 days', '2025-12-19'::timestamptz - interval '154 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Nguyen', 'micro1.synth.93@example.test', '+92316042563') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '201 days', '2025-12-19'::timestamptz - interval '201 days' + interval '3 days', '2025-12-19'::timestamptz - interval '201 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Okafor', 'micro1.synth.94@example.test', '+92314133099') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '248 days', '2025-12-19'::timestamptz - interval '248 days' + interval '3 days', '2025-12-19'::timestamptz - interval '248 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Park', 'micro1.synth.95@example.test', '+92312857326') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '295 days', '2025-12-19'::timestamptz - interval '295 days' + interval '3 days', '2025-12-19'::timestamptz - interval '295 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Fernandez', 'micro1.synth.96@example.test', '+92311525584') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '342 days', '2025-12-19'::timestamptz - interval '342 days' + interval '3 days', '2025-12-19'::timestamptz - interval '342 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Tran', 'micro1.synth.97@example.test', '+92312890516') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', '2025-12-19'::timestamptz - interval '389 days', '2025-12-19'::timestamptz - interval '389 days' + interval '3 days', '2025-12-19'::timestamptz - interval '389 days' + interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Nguyen', 'micro1.synth.98@example.test', '+92319376984') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '436 days', '2025-12-19'::timestamptz - interval '436 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '436 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Yamamoto', 'micro1.synth.99@example.test', '+92312771153') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '63 days', '2025-12-19'::timestamptz - interval '63 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '63 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Okafor', 'micro1.synth.100@example.test', '+92318619261') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '110 days', '2025-12-19'::timestamptz - interval '110 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '110 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Wong', 'micro1.synth.101@example.test', '+92311009111') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '157 days', '2025-12-19'::timestamptz - interval '157 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kofi', 'Al-Rashid', 'micro1.synth.102@example.test', '+92312828918') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '204 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Tanaka', 'micro1.synth.103@example.test', '+92316039368') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '251 days', '2025-12-19'::timestamptz - interval '251 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '251 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kofi', 'Nguyen', 'micro1.synth.104@example.test', '+92319184068') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '298 days', '2025-12-19'::timestamptz - interval '298 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '298 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lopez', 'micro1.synth.105@example.test', '+92316714809') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '345 days', '2025-12-19'::timestamptz - interval '345 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '345 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Al-Rashid', 'micro1.synth.106@example.test', '+92311756568') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '392 days', '2025-12-19'::timestamptz - interval '392 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Fernandez', 'micro1.synth.107@example.test', '+92313732945') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '439 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Lin', 'micro1.synth.108@example.test', '+92315600207') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '66 days', '2025-12-19'::timestamptz - interval '66 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '66 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Lin', 'micro1.synth.109@example.test', '+92313870742') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '113 days', '2025-12-19'::timestamptz - interval '113 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '113 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Davis', 'micro1.synth.110@example.test', '+92314616071') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '160 days', '2025-12-19'::timestamptz - interval '160 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '160 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Yamamoto', 'micro1.synth.111@example.test', '+92316169194') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '207 days', '2025-12-19'::timestamptz - interval '207 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Muller', 'micro1.synth.112@example.test', '+92319909695') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '254 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Chen', 'micro1.synth.113@example.test', '+92311731102') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '301 days', '2025-12-19'::timestamptz - interval '301 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '301 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Rossi', 'micro1.synth.114@example.test', '+92312439382') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '348 days', '2025-12-19'::timestamptz - interval '348 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '348 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Osei', 'micro1.synth.115@example.test', '+92312519404') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '395 days', '2025-12-19'::timestamptz - interval '395 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '395 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Nguyen', 'micro1.synth.116@example.test', '+92315225914') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '442 days', '2025-12-19'::timestamptz - interval '442 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan', 'micro1.synth.117@example.test', '+92314400904') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '69 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anh', 'Kato', 'micro1.synth.118@example.test', '+92311545493') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '116 days', '2025-12-19'::timestamptz - interval '116 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '116 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kato', 'micro1.synth.119@example.test', '+92311996902') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '163 days', '2025-12-19'::timestamptz - interval '163 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '163 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Davis', 'micro1.synth.120@example.test', '+92319306847') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '210 days', '2025-12-19'::timestamptz - interval '210 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '210 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Suzuki', 'micro1.synth.121@example.test', '+92312662131') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '257 days', '2025-12-19'::timestamptz - interval '257 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Okafor', 'micro1.synth.122@example.test', '+92319232362') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '304 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Rodriguez', 'micro1.synth.123@example.test', '+92312464113') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '351 days', '2025-12-19'::timestamptz - interval '351 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '351 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Nguyen', 'micro1.synth.124@example.test', '+92312416683') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '398 days', '2025-12-19'::timestamptz - interval '398 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '398 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amara', 'Wong', 'micro1.synth.125@example.test', '+92311918815') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '445 days', '2025-12-19'::timestamptz - interval '445 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '445 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Suzuki', 'micro1.synth.126@example.test', '+92315160468') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '72 days', '2025-12-19'::timestamptz - interval '72 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Rossi', 'micro1.synth.127@example.test', '+92318691768') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '119 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Park', 'micro1.synth.128@example.test', '+92318383608') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '166 days', '2025-12-19'::timestamptz - interval '166 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '166 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Wanjiru', 'micro1.synth.129@example.test', '+92313902527') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '213 days', '2025-12-19'::timestamptz - interval '213 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '213 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Chen', 'micro1.synth.130@example.test', '+92314867559') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '260 days', '2025-12-19'::timestamptz - interval '260 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '260 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Haruto', 'Muller', 'micro1.synth.131@example.test', '+92312764842') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '307 days', '2025-12-19'::timestamptz - interval '307 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amara', 'Fernandez', 'micro1.synth.132@example.test', '+92313497997') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '354 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Chen', 'micro1.synth.133@example.test', '+92312855748') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '401 days', '2025-12-19'::timestamptz - interval '401 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '401 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Wong', 'micro1.synth.134@example.test', '+92311422282') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '448 days', '2025-12-19'::timestamptz - interval '448 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '448 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Hassan', 'micro1.synth.135@example.test', '+92318148126') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '75 days', '2025-12-19'::timestamptz - interval '75 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '75 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Okafor', 'micro1.synth.136@example.test', '+92318923845') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '122 days', '2025-12-19'::timestamptz - interval '122 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Park', 'micro1.synth.137@example.test', '+92315286733') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '169 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Rossi', 'micro1.synth.138@example.test', '+92318433774') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '216 days', '2025-12-19'::timestamptz - interval '216 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '216 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Wong', 'micro1.synth.139@example.test', '+92315330160') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '263 days', '2025-12-19'::timestamptz - interval '263 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '263 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Nguyen', 'micro1.synth.140@example.test', '+92316049053') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '310 days', '2025-12-19'::timestamptz - interval '310 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '310 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Okafor', 'micro1.synth.141@example.test', '+92316214526') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '357 days', '2025-12-19'::timestamptz - interval '357 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Wanjiru', 'micro1.synth.142@example.test', '+92314580495') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '404 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Suzuki', 'micro1.synth.143@example.test', '+92311616604') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '31 days', '2025-12-19'::timestamptz - interval '31 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '31 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ibrahim', 'Fernandez', 'micro1.synth.144@example.test', '+92312971323') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '78 days', '2025-12-19'::timestamptz - interval '78 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '78 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Wong', 'micro1.synth.145@example.test', '+92312018274') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '125 days', '2025-12-19'::timestamptz - interval '125 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '125 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ngozi', 'Chen', 'micro1.synth.146@example.test', '+92312912739') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '172 days', '2025-12-19'::timestamptz - interval '172 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim', 'micro1.synth.147@example.test', '+92318950422') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '219 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Rossi', 'micro1.synth.148@example.test', '+92311423485') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '266 days', '2025-12-19'::timestamptz - interval '266 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '266 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Wong', 'micro1.synth.149@example.test', '+92311986005') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '313 days', '2025-12-19'::timestamptz - interval '313 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '313 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Seo-yeon', 'Suzuki', 'micro1.synth.150@example.test', '+92318750189') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '360 days', '2025-12-19'::timestamptz - interval '360 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '360 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Tran', 'micro1.synth.151@example.test', '+92319468268') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '407 days', '2025-12-19'::timestamptz - interval '407 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Okafor', 'micro1.synth.152@example.test', '+92313688836') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '34 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Lopez', 'micro1.synth.153@example.test', '+92315531064') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '81 days', '2025-12-19'::timestamptz - interval '81 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '81 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Al-Sayed', 'micro1.synth.154@example.test', '+92317540088') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '128 days', '2025-12-19'::timestamptz - interval '128 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '128 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Osei', 'micro1.synth.155@example.test', '+92312797912') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '175 days', '2025-12-19'::timestamptz - interval '175 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '175 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Al-Sayed', 'micro1.synth.156@example.test', '+92312885544') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '222 days', '2025-12-19'::timestamptz - interval '222 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Wanjiru', 'micro1.synth.157@example.test', '+92313242981') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '269 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Okafor', 'micro1.synth.158@example.test', '+92316126799') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '316 days', '2025-12-19'::timestamptz - interval '316 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '316 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Ibrahim', 'micro1.synth.159@example.test', '+92319732161') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '363 days', '2025-12-19'::timestamptz - interval '363 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '363 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kwame', 'Kato', 'micro1.synth.160@example.test', '+92314066545') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '410 days', '2025-12-19'::timestamptz - interval '410 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '410 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Mensah', 'micro1.synth.161@example.test', '+92316349190') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '37 days', '2025-12-19'::timestamptz - interval '37 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Park', 'micro1.synth.162@example.test', '+92317010350') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '84 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Lopez', 'micro1.synth.163@example.test', '+92316506265') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '131 days', '2025-12-19'::timestamptz - interval '131 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '131 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Davis', 'micro1.synth.164@example.test', '+92315455028') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '178 days', '2025-12-19'::timestamptz - interval '178 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '178 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Yamamoto', 'micro1.synth.165@example.test', '+92316335327') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '225 days', '2025-12-19'::timestamptz - interval '225 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '225 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amara', 'Muller', 'micro1.synth.166@example.test', '+92315492033') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '272 days', '2025-12-19'::timestamptz - interval '272 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Wong', 'micro1.synth.167@example.test', '+92315487325') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '319 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Osei', 'micro1.synth.168@example.test', '+92311266868') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '366 days', '2025-12-19'::timestamptz - interval '366 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '366 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Ibrahim', 'micro1.synth.169@example.test', '+92315858696') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '413 days', '2025-12-19'::timestamptz - interval '413 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '413 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Rossi', 'micro1.synth.170@example.test', '+92311086513') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '40 days', '2025-12-19'::timestamptz - interval '40 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '40 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Rossi', 'micro1.synth.171@example.test', '+92311934757') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '87 days', '2025-12-19'::timestamptz - interval '87 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Okafor', 'micro1.synth.172@example.test', '+92313814862') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '134 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Al-Rashid', 'micro1.synth.173@example.test', '+92316097476') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '181 days', '2025-12-19'::timestamptz - interval '181 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '181 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Kim', 'micro1.synth.174@example.test', '+92315445934') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '228 days', '2025-12-19'::timestamptz - interval '228 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '228 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ibrahim', 'Ibrahim', 'micro1.synth.175@example.test', '+92313147808') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '275 days', '2025-12-19'::timestamptz - interval '275 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '275 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Haruto', 'Suzuki', 'micro1.synth.176@example.test', '+92315729983') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '322 days', '2025-12-19'::timestamptz - interval '322 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ngozi', 'Osei', 'micro1.synth.177@example.test', '+92317355214') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '369 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Kim', 'micro1.synth.178@example.test', '+92312699693') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '416 days', '2025-12-19'::timestamptz - interval '416 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '416 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Kato', 'micro1.synth.179@example.test', '+92316841648') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '43 days', '2025-12-19'::timestamptz - interval '43 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '43 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Osei', 'micro1.synth.180@example.test', '+92311620497') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '90 days', '2025-12-19'::timestamptz - interval '90 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '90 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Al-Rashid', 'micro1.synth.181@example.test', '+92318266279') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '137 days', '2025-12-19'::timestamptz - interval '137 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Haruto', 'Okafor', 'micro1.synth.182@example.test', '+92314183439') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '184 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Abara', 'micro1.synth.183@example.test', '+92317471373') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '231 days', '2025-12-19'::timestamptz - interval '231 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '231 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Al-Rashid', 'micro1.synth.184@example.test', '+92314635779') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '278 days', '2025-12-19'::timestamptz - interval '278 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '278 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Lopez', 'micro1.synth.185@example.test', '+92312456136') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '325 days', '2025-12-19'::timestamptz - interval '325 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '325 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Ibrahim', 'micro1.synth.186@example.test', '+92313126439') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '372 days', '2025-12-19'::timestamptz - interval '372 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Chen', 'micro1.synth.187@example.test', '+92315374301') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '419 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Minjun', 'Mensah', 'micro1.synth.188@example.test', '+92314158311') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '46 days', '2025-12-19'::timestamptz - interval '46 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '46 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Chen', 'micro1.synth.189@example.test', '+92318743819') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '93 days', '2025-12-19'::timestamptz - interval '93 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '93 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Rodriguez', 'micro1.synth.190@example.test', '+92314600875') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '140 days', '2025-12-19'::timestamptz - interval '140 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '140 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Rossi', 'micro1.synth.191@example.test', '+92318736494') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '187 days', '2025-12-19'::timestamptz - interval '187 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Yamamoto', 'micro1.synth.192@example.test', '+92315476865') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '234 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Davis', 'micro1.synth.193@example.test', '+92318216742') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '281 days', '2025-12-19'::timestamptz - interval '281 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '281 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Minjun', 'Al-Rashid', 'micro1.synth.194@example.test', '+92315802993') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '328 days', '2025-12-19'::timestamptz - interval '328 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '328 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Mensah', 'micro1.synth.195@example.test', '+92317929850') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '375 days', '2025-12-19'::timestamptz - interval '375 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '375 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Okafor', 'micro1.synth.196@example.test', '+92316902450') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '422 days', '2025-12-19'::timestamptz - interval '422 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Nguyen', 'micro1.synth.197@example.test', '+92314913918') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '49 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Davis', 'micro1.synth.198@example.test', '+92319067720') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '96 days', '2025-12-19'::timestamptz - interval '96 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '96 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Ibrahim', 'micro1.synth.199@example.test', '+92314158952') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '143 days', '2025-12-19'::timestamptz - interval '143 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '143 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Kato', 'micro1.synth.200@example.test', '+92312448962') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '190 days', '2025-12-19'::timestamptz - interval '190 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '190 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Lin', 'micro1.synth.201@example.test', '+92315229323') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '237 days', '2025-12-19'::timestamptz - interval '237 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Chen', 'micro1.synth.202@example.test', '+92316436462') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '284 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Tran', 'micro1.synth.203@example.test', '+92311176408') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '331 days', '2025-12-19'::timestamptz - interval '331 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '331 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Fernandez', 'micro1.synth.204@example.test', '+92319432618') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '378 days', '2025-12-19'::timestamptz - interval '378 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '378 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Tanaka', 'micro1.synth.205@example.test', '+92318260936') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '425 days', '2025-12-19'::timestamptz - interval '425 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '425 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Wanjiru', 'micro1.synth.206@example.test', '+92317305722') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '52 days', '2025-12-19'::timestamptz - interval '52 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Hassan', 'micro1.synth.207@example.test', '+92314308462') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '99 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Nguyen', 'micro1.synth.208@example.test', '+92313344401') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '146 days', '2025-12-19'::timestamptz - interval '146 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '146 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Tran', 'micro1.synth.209@example.test', '+92318309035') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '193 days', '2025-12-19'::timestamptz - interval '193 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '193 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Mensah', 'micro1.synth.210@example.test', '+92311603155') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '240 days', '2025-12-19'::timestamptz - interval '240 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '240 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Lin', 'micro1.synth.211@example.test', '+92319335207') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '287 days', '2025-12-19'::timestamptz - interval '287 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Wanjiru', 'micro1.synth.212@example.test', '+92313892571') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '334 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Fernandez', 'micro1.synth.213@example.test', '+92312511295') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '381 days', '2025-12-19'::timestamptz - interval '381 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '381 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Okafor', 'micro1.synth.214@example.test', '+92311027472') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '428 days', '2025-12-19'::timestamptz - interval '428 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '428 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Lin', 'micro1.synth.215@example.test', '+92311181384') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '55 days', '2025-12-19'::timestamptz - interval '55 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '55 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Okafor', 'micro1.synth.216@example.test', '+92312917169') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '102 days', '2025-12-19'::timestamptz - interval '102 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Linh', 'Al-Rashid', 'micro1.synth.217@example.test', '+92314038147') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '149 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Tanaka', 'micro1.synth.218@example.test', '+92314796917') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '196 days', '2025-12-19'::timestamptz - interval '196 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '196 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Tanaka', 'micro1.synth.219@example.test', '+92316823690') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '243 days', '2025-12-19'::timestamptz - interval '243 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '243 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Kato', 'micro1.synth.220@example.test', '+92317376337') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '290 days', '2025-12-19'::timestamptz - interval '290 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '290 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Davis', 'micro1.synth.221@example.test', '+92319885224') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '337 days', '2025-12-19'::timestamptz - interval '337 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Hassan', 'micro1.synth.222@example.test', '+92313700434') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '384 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Osei', 'micro1.synth.223@example.test', '+92319887646') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '431 days', '2025-12-19'::timestamptz - interval '431 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '431 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Al-Rashid', 'micro1.synth.224@example.test', '+92319178952') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '58 days', '2025-12-19'::timestamptz - interval '58 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '58 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Ibrahim', 'micro1.synth.225@example.test', '+92315288142') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '105 days', '2025-12-19'::timestamptz - interval '105 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '105 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kofi', 'Kato', 'micro1.synth.226@example.test', '+92311220054') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '152 days', '2025-12-19'::timestamptz - interval '152 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Osei', 'micro1.synth.227@example.test', '+92319913607') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '199 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Al-Sayed', 'micro1.synth.228@example.test', '+92318568322') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '246 days', '2025-12-19'::timestamptz - interval '246 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '246 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Lin', 'micro1.synth.229@example.test', '+92313148845') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '293 days', '2025-12-19'::timestamptz - interval '293 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '293 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Hassan', 'micro1.synth.230@example.test', '+92315688226') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '340 days', '2025-12-19'::timestamptz - interval '340 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '340 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Kim', 'micro1.synth.231@example.test', '+92317676915') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '387 days', '2025-12-19'::timestamptz - interval '387 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Rossi', 'micro1.synth.232@example.test', '+92315546091') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '434 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ibrahim', 'Osei', 'micro1.synth.233@example.test', '+92314456755') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '61 days', '2025-12-19'::timestamptz - interval '61 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '61 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Fernandez', 'micro1.synth.234@example.test', '+92318286467') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '108 days', '2025-12-19'::timestamptz - interval '108 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '108 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Al-Rashid', 'micro1.synth.235@example.test', '+92316450850') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '155 days', '2025-12-19'::timestamptz - interval '155 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '155 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Chen', 'micro1.synth.236@example.test', '+92316704023') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '202 days', '2025-12-19'::timestamptz - interval '202 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Mensah', 'micro1.synth.237@example.test', '+92318069488') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '249 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Lin', 'micro1.synth.238@example.test', '+92314766865') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '296 days', '2025-12-19'::timestamptz - interval '296 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '296 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Karim', 'Wanjiru', 'micro1.synth.239@example.test', '+92316927499') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '343 days', '2025-12-19'::timestamptz - interval '343 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '343 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Seo-yeon', 'Kato', 'micro1.synth.240@example.test', '+92313653025') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '390 days', '2025-12-19'::timestamptz - interval '390 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '390 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tran', 'micro1.synth.241@example.test', '+92313452270') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '437 days', '2025-12-19'::timestamptz - interval '437 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Chen', 'micro1.synth.242@example.test', '+92319363416') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '64 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kofi', 'Rodriguez', 'micro1.synth.243@example.test', '+92316923006') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '111 days', '2025-12-19'::timestamptz - interval '111 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '111 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Davis', 'micro1.synth.244@example.test', '+92318002658') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '158 days', '2025-12-19'::timestamptz - interval '158 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '158 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chen', 'Abara', 'micro1.synth.245@example.test', '+92314928328') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '205 days', '2025-12-19'::timestamptz - interval '205 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '205 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Kim', 'micro1.synth.246@example.test', '+92312075659') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '252 days', '2025-12-19'::timestamptz - interval '252 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Park', 'micro1.synth.247@example.test', '+92317685086') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '299 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kwame', 'Al-Sayed', 'micro1.synth.248@example.test', '+92315487168') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '346 days', '2025-12-19'::timestamptz - interval '346 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '346 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Ibrahim', 'micro1.synth.249@example.test', '+92313581246') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '393 days', '2025-12-19'::timestamptz - interval '393 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '393 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Yamamoto', 'micro1.synth.250@example.test', '+92319890466') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '440 days', '2025-12-19'::timestamptz - interval '440 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '440 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ngozi', 'Yamamoto', 'micro1.synth.251@example.test', '+92316331551') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '67 days', '2025-12-19'::timestamptz - interval '67 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Al-Rashid', 'micro1.synth.252@example.test', '+92313975911') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '114 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Haruto', 'Osei', 'micro1.synth.253@example.test', '+92312368882') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '161 days', '2025-12-19'::timestamptz - interval '161 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '161 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Osei', 'micro1.synth.254@example.test', '+92313952951') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '208 days', '2025-12-19'::timestamptz - interval '208 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '208 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Lopez', 'micro1.synth.255@example.test', '+92319828506') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '255 days', '2025-12-19'::timestamptz - interval '255 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '255 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sakura', 'Nguyen', 'micro1.synth.256@example.test', '+92319552876') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '302 days', '2025-12-19'::timestamptz - interval '302 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Abara', 'micro1.synth.257@example.test', '+92318046612') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '349 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Kato', 'micro1.synth.258@example.test', '+92317610788') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '396 days', '2025-12-19'::timestamptz - interval '396 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '396 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Fernandez', 'micro1.synth.259@example.test', '+92312152317') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '443 days', '2025-12-19'::timestamptz - interval '443 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '443 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yusuf', 'Fernandez', 'micro1.synth.260@example.test', '+92312426150') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '70 days', '2025-12-19'::timestamptz - interval '70 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '70 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Zainab', 'Al-Sayed', 'micro1.synth.261@example.test', '+92312976149') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '117 days', '2025-12-19'::timestamptz - interval '117 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Suzuki', 'micro1.synth.262@example.test', '+92316143357') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '164 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Haruto', 'Rossi', 'micro1.synth.263@example.test', '+92313642911') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '211 days', '2025-12-19'::timestamptz - interval '211 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '211 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Tariq', 'Al-Rashid', 'micro1.synth.264@example.test', '+92318224837') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '258 days', '2025-12-19'::timestamptz - interval '258 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '258 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Fernandez', 'micro1.synth.265@example.test', '+92313968244') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '305 days', '2025-12-19'::timestamptz - interval '305 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '305 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Al-Sayed', 'micro1.synth.266@example.test', '+92312199918') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '352 days', '2025-12-19'::timestamptz - interval '352 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Tran', 'micro1.synth.267@example.test', '+92313206138') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '399 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Nguyen', 'micro1.synth.268@example.test', '+92316568473') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '446 days', '2025-12-19'::timestamptz - interval '446 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '446 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hassan', 'Osei', 'micro1.synth.269@example.test', '+92312700367') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '73 days', '2025-12-19'::timestamptz - interval '73 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '73 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Yamamoto', 'micro1.synth.270@example.test', '+92317639016') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '120 days', '2025-12-19'::timestamptz - interval '120 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '120 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chioma', 'Wanjiru', 'micro1.synth.271@example.test', '+92312176709') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', '2025-12-19'::timestamptz - interval '167 days', '2025-12-19'::timestamptz - interval '167 days' + interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Li', 'Abara', 'micro1.synth.272@example.test', '+92315215710') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', '2025-12-19'::timestamptz - interval '214 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aisha', 'Lin', 'micro1.synth.273@example.test', '+92311110320') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '261 days', '2025-12-19'::timestamptz - interval '261 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '261 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mohammed', 'Wong', 'micro1.synth.274@example.test', '+92315439535') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '308 days', '2025-12-19'::timestamptz - interval '308 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '308 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kofi', 'Lopez', 'micro1.synth.275@example.test', '+92314193622') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', '2025-12-19'::timestamptz - interval '355 days', '2025-12-19'::timestamptz - interval '355 days' + interval '3 days', NULL, '2025-12-19'::timestamptz - interval '355 days' + interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

END $$;

-- Exact target: Haider's Turing bonuses = $0 paid, $1400 remaining.
-- All his Turing bonus_records stay 'remaining' (none paid); adjust one
-- record's amount so the sum lands on exactly 1400.
DO $$
DECLARE
  haider_acct UUID;
  current_sum NUMERIC;
  adjust_id UUID;
  delta NUMERIC;
BEGIN
  SELECT id INTO haider_acct FROM public.accounts WHERE platform_id = '22222222-2222-2222-2222-222222222222' AND name = 'Haider';
  SELECT coalesce(sum(amount), 0) INTO current_sum FROM public.bonus_records br
    JOIN public.referrals r ON r.id = br.referral_id
    WHERE r.account_id = haider_acct AND r.platform_id = '22222222-2222-2222-2222-222222222222';
  SELECT br.id INTO adjust_id FROM public.bonus_records br
    JOIN public.referrals r ON r.id = br.referral_id
    WHERE r.account_id = haider_acct AND r.platform_id = '22222222-2222-2222-2222-222222222222'
    ORDER BY br.created_at DESC LIMIT 1;
  delta := 1400 - current_sum;
  IF adjust_id IS NOT NULL THEN
    UPDATE public.bonus_records SET amount = amount + delta WHERE id = adjust_id;
  END IF;
END $$;

-- Exact target: Hanzala received (paid) exactly $1650 from Turing - 11 of
-- his $150 bonus_records marked paid (11 x 150 = 1650 exactly).
DO $$
DECLARE
  hanzala_acct UUID;
  rec RECORD;
BEGIN
  SELECT id INTO hanzala_acct FROM public.accounts WHERE platform_id = '22222222-2222-2222-2222-222222222222' AND name = 'Hanzala';
  FOR rec IN
    SELECT br.id FROM public.bonus_records br
    JOIN public.referrals r ON r.id = br.referral_id
    WHERE r.account_id = hanzala_acct AND r.platform_id = '22222222-2222-2222-2222-222222222222'
      AND br.status = 'remaining' AND br.amount = 150
    ORDER BY br.created_at
    LIMIT 11
  LOOP
    UPDATE public.bonus_records SET status = 'paid', paid_at = earned_at + interval '10 days', exchange_rate_used = 265 WHERE id = rec.id;
  END LOOP;
END $$;

-- Realistic paid/pending split for everyone else (excluding Haider/Hanzala's
-- Turing records, which are pinned to the exact targets above).
WITH eligible AS (
  SELECT br.id FROM public.bonus_records br
  JOIN public.referrals r ON r.id = br.referral_id
  JOIN public.accounts a ON a.id = r.account_id
  WHERE br.status = 'remaining'
    AND NOT (r.platform_id = '22222222-2222-2222-2222-222222222222' AND a.name IN ('Haider', 'Hanzala'))
),
to_pay AS (
  SELECT id FROM eligible ORDER BY random() LIMIT (SELECT ceil(count(*) * 0.3) FROM eligible)
)
UPDATE public.bonus_records
SET status = 'paid', paid_at = earned_at + ((random() * 20 + 3) || ' days')::interval, exchange_rate_used = 265
WHERE id IN (SELECT id FROM to_pay);
