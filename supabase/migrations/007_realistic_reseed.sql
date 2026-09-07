-- Realistic reseed: replaces generic mock data with real Turing referral
-- history (from an actual referral tracker) plus synthetic padding matching
-- real candidate geography per platform, and a paid/pending split instead of
-- every bonus sitting at "remaining". Does NOT touch users/auth.users.

-- Wipe prior mock referral data (children first, respecting FKs). Real user
-- accounts (auth.users / public.users) are untouched.
DELETE FROM public.bonus_records;
DELETE FROM public.referral_status_history;
DELETE FROM public.emails;
DELETE FROM public.referrals;
DELETE FROM public.candidates;
DELETE FROM public.jobs WHERE platform_id = '22222222-2222-2222-2222-222222222222';
DELETE FROM public.accounts WHERE platform_id = '22222222-2222-2222-2222-222222222222';

-- Real Turing referral accounts (the actual people who refer candidates).
INSERT INTO public.accounts (platform_id, name, identifier) VALUES
  ('22222222-2222-2222-2222-222222222222', 'Hanzala', 'turing-hanzala'),
  ('22222222-2222-2222-2222-222222222222', 'Haider', 'turing-haider'),
  ('22222222-2222-2222-2222-222222222222', 'Momina Saleem', 'turing-momina'),
  ('22222222-2222-2222-2222-222222222222', 'Anas Hafeez', 'turing-anas'),
  ('22222222-2222-2222-2222-222222222222', 'Urwa Hafeez', 'turing-urwa');

-- Real Turing project/task titles.
INSERT INTO public.jobs (platform_id, title)
SELECT '22222222-2222-2222-2222-222222222222', title FROM (VALUES
  ('Small business Owner AI response AI evaluation'),
  ('Creative Software specialist ( Open source Tools)'),
  ('LLM -Trainer Agent Function call'),
  ('Text 2SQL developer'),
  ('AI Trainer Business Analyst'),
  ('Business Analyst'),
  ('Senior Software Engineer LLM Evaluation'),
  ('AI quality Analyst English'),
  ('AI quality Analyst  English'),
  ('LLM S3 Annotator (Open Claw Trajectory Specialist)'),
  ('Software Engineer With Python and Docker'),
  ('Mathematics Expert PH.d'),
  ('LLM Trainer Software Engineer SWE'),
  ('Tax Form Expert'),
  ('Data Anotator Ubuntu Desktop Operator'),
  ('Video Annotator'),
  ('Video Data Annotator'),
  ('Business Analyst (RLHF/  Analyst )'),
  ('LLM S2 Annotator (CUA Trajectory Specialist)'),
  ('Agentic Coding Annotator Online/ Offline Tasks'),
  ('Gaming Specialist'),
  ('LLM Trainer Agent Function Call'),
  ('AI safety and Policy Analyst'),
  ('Data Science /Anlayst'),
  ('AI trainer Agent Function Call'),
  ('Text 2SQL Developer'),
  ('Astronomical Computation Engineer'),
  ('LLM Python Reviwer'),
  ('LLM Data quality and tooling Specialist'),
  ('Senior Software Engineer- LLM Evaluation'),
  ('Technical Content Writer'),
  ('Data Annotaor Ubuntu Desktop operator'),
  ('Image / Video Annotator'),
  ('Data Annotator Ubuntu Desktop Operator'),
  ('Docker file Data validation Engineer'),
  ('Data Annotator ubuntu Desktop Operator'),
  ('Text2SQL Developer'),
  ('Software Engineer With Python and Docker Exerience'),
  ('Dockerfile Data validation Engineer'),
  ('AI Bench Mark engineer'),
  ('LLM Trainer Terminal Bench (Python & Linux system)')
) AS t(title);

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

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi', 'turing.synth.0@example.test', '+9231000000') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '5 days', now() - interval '2 days', now() - interval '-5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini', 'turing.synth.1@example.test', '+9231000001') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '46 days', now() - interval '43 days', now() - interval '36 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo', 'turing.synth.2@example.test', '+9231000002') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '87 days', now() - interval '84 days', now() - interval '77 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena', 'turing.synth.3@example.test', '+9231000003') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '128 days', now() - interval '125 days', now() - interval '118 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu', 'turing.synth.4@example.test', '+9231000004') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '169 days', now() - interval '166 days', now() - interval '159 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu', 'turing.synth.5@example.test', '+9231000005') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '10 days', now() - interval '7 days', now() - interval '0 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole', 'turing.synth.6@example.test', '+9231000006') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '51 days', now() - interval '48 days', now() - interval '41 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza', 'turing.synth.7@example.test', '+9231000007') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '92 days', now() - interval '89 days', now() - interval '82 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe', 'turing.synth.8@example.test', '+9231000008') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '133 days', now() - interval '130 days', now() - interval '123 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma', 'turing.synth.9@example.test', '+9231000009') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '174 days', now() - interval '171 days', now() - interval '164 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma', 'turing.synth.10@example.test', '+9231000010') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '15 days', now() - interval '12 days', now() - interval '5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer', 'turing.synth.11@example.test', '+9231000011') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '56 days', now() - interval '53 days', now() - interval '46 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh', 'turing.synth.12@example.test', '+9231000012') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '97 days', now() - interval '94 days', now() - interval '87 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta', 'turing.synth.13@example.test', '+9231000013') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '138 days', now() - interval '135 days', now() - interval '128 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy', 'turing.synth.14@example.test', '+9231000014') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '179 days', now() - interval '176 days', now() - interval '169 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair', 'turing.synth.15@example.test', '+9231000015') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '20 days', now() - interval '17 days', now() - interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta', 'turing.synth.16@example.test', '+9231000016') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '61 days', now() - interval '58 days', now() - interval '51 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel', 'turing.synth.17@example.test', '+9231000017') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '102 days', now() - interval '99 days', now() - interval '92 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar', 'turing.synth.18@example.test', '+9231000018') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '143 days', now() - interval '140 days', now() - interval '133 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon', 'turing.synth.19@example.test', '+9231000019') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '184 days', now() - interval '181 days', now() - interval '174 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 2', 'turing.synth.20@example.test', '+9231000020') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '25 days', now() - interval '22 days', now() - interval '15 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 2', 'turing.synth.21@example.test', '+9231000021') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '66 days', now() - interval '63 days', now() - interval '56 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 2', 'turing.synth.22@example.test', '+9231000022') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '107 days', now() - interval '104 days', now() - interval '97 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 2', 'turing.synth.23@example.test', '+9231000023') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '148 days', now() - interval '145 days', now() - interval '138 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 2', 'turing.synth.24@example.test', '+9231000024') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '189 days', now() - interval '186 days', now() - interval '179 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 2', 'turing.synth.25@example.test', '+9231000025') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '30 days', now() - interval '27 days', now() - interval '20 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 2', 'turing.synth.26@example.test', '+9231000026') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '71 days', now() - interval '68 days', now() - interval '61 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 2', 'turing.synth.27@example.test', '+9231000027') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '112 days', now() - interval '109 days', now() - interval '102 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 2', 'turing.synth.28@example.test', '+9231000028') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '153 days', now() - interval '150 days', now() - interval '143 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 2', 'turing.synth.29@example.test', '+9231000029') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '194 days', now() - interval '191 days', now() - interval '184 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 2', 'turing.synth.30@example.test', '+9231000030') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '35 days', now() - interval '32 days', now() - interval '25 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 2', 'turing.synth.31@example.test', '+9231000031') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '76 days', now() - interval '73 days', now() - interval '66 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 2', 'turing.synth.32@example.test', '+9231000032') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '117 days', now() - interval '114 days', now() - interval '107 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 2', 'turing.synth.33@example.test', '+9231000033') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '158 days', now() - interval '155 days', now() - interval '148 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 2', 'turing.synth.34@example.test', '+9231000034') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '199 days', now() - interval '196 days', now() - interval '189 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 2', 'turing.synth.35@example.test', '+9231000035') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '40 days', now() - interval '37 days', now() - interval '30 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 2', 'turing.synth.36@example.test', '+9231000036') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '81 days', now() - interval '78 days', now() - interval '71 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 2', 'turing.synth.37@example.test', '+9231000037') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '122 days', now() - interval '119 days', now() - interval '112 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 2', 'turing.synth.38@example.test', '+9231000038') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '163 days', now() - interval '160 days', now() - interval '153 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 2', 'turing.synth.39@example.test', '+9231000039') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '204 days', now() - interval '201 days', now() - interval '194 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 3', 'turing.synth.40@example.test', '+9231000040') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '45 days', now() - interval '42 days', now() - interval '35 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 3', 'turing.synth.41@example.test', '+9231000041') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'hired', now() - interval '86 days', now() - interval '83 days', now() - interval '76 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 3', 'turing.synth.42@example.test', '+9231000042') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '127 days', now() - interval '124 days', NULL, now() - interval '118 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 3', 'turing.synth.43@example.test', '+9231000043') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '168 days', now() - interval '165 days', NULL, now() - interval '159 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 3', 'turing.synth.44@example.test', '+9231000044') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '9 days', now() - interval '6 days', NULL, now() - interval '0 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 3', 'turing.synth.45@example.test', '+9231000045') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '50 days', now() - interval '47 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 3', 'turing.synth.46@example.test', '+9231000046') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '91 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 3', 'turing.synth.47@example.test', '+9231000047') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '132 days', now() - interval '129 days', NULL, now() - interval '123 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 3', 'turing.synth.48@example.test', '+9231000048') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '173 days', now() - interval '170 days', NULL, now() - interval '164 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 3', 'turing.synth.49@example.test', '+9231000049') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '14 days', now() - interval '11 days', NULL, now() - interval '5 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 3', 'turing.synth.50@example.test', '+9231000050') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '55 days', now() - interval '52 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 3', 'turing.synth.51@example.test', '+9231000051') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '96 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 3', 'turing.synth.52@example.test', '+9231000052') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '137 days', now() - interval '134 days', NULL, now() - interval '128 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 3', 'turing.synth.53@example.test', '+9231000053') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '178 days', now() - interval '175 days', NULL, now() - interval '169 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 3', 'turing.synth.54@example.test', '+9231000054') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '19 days', now() - interval '16 days', NULL, now() - interval '10 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 3', 'turing.synth.55@example.test', '+9231000055') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '60 days', now() - interval '57 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 3', 'turing.synth.56@example.test', '+9231000056') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '101 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 3', 'turing.synth.57@example.test', '+9231000057') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '142 days', now() - interval '139 days', NULL, now() - interval '133 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 3', 'turing.synth.58@example.test', '+9231000058') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '183 days', now() - interval '180 days', NULL, now() - interval '174 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 3', 'turing.synth.59@example.test', '+9231000059') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '24 days', now() - interval '21 days', NULL, now() - interval '15 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 4', 'turing.synth.60@example.test', '+9231000060') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '65 days', now() - interval '62 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 4', 'turing.synth.61@example.test', '+9231000061') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '106 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 4', 'turing.synth.62@example.test', '+9231000062') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '147 days', now() - interval '144 days', NULL, now() - interval '138 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 4', 'turing.synth.63@example.test', '+9231000063') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '188 days', now() - interval '185 days', NULL, now() - interval '179 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 4', 'turing.synth.64@example.test', '+9231000064') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '29 days', now() - interval '26 days', NULL, now() - interval '20 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 4', 'turing.synth.65@example.test', '+9231000065') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '70 days', now() - interval '67 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 4', 'turing.synth.66@example.test', '+9231000066') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '111 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 4', 'turing.synth.67@example.test', '+9231000067') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '152 days', now() - interval '149 days', NULL, now() - interval '143 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 4', 'turing.synth.68@example.test', '+9231000068') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '193 days', now() - interval '190 days', NULL, now() - interval '184 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 4', 'turing.synth.69@example.test', '+9231000069') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '34 days', now() - interval '31 days', NULL, now() - interval '25 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 4', 'turing.synth.70@example.test', '+9231000070') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '75 days', now() - interval '72 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 4', 'turing.synth.71@example.test', '+9231000071') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '116 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 4', 'turing.synth.72@example.test', '+9231000072') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '157 days', now() - interval '154 days', NULL, now() - interval '148 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 4', 'turing.synth.73@example.test', '+9231000073') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '198 days', now() - interval '195 days', NULL, now() - interval '189 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 4', 'turing.synth.74@example.test', '+9231000074') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '39 days', now() - interval '36 days', NULL, now() - interval '30 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 4', 'turing.synth.75@example.test', '+9231000075') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '80 days', now() - interval '77 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 4', 'turing.synth.76@example.test', '+9231000076') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '121 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 4', 'turing.synth.77@example.test', '+9231000077') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '162 days', now() - interval '159 days', NULL, now() - interval '153 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 4', 'turing.synth.78@example.test', '+9231000078') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '203 days', now() - interval '200 days', NULL, now() - interval '194 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 4', 'turing.synth.79@example.test', '+9231000079') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '44 days', now() - interval '41 days', NULL, now() - interval '35 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 5', 'turing.synth.80@example.test', '+9231000080') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '85 days', now() - interval '82 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 5', 'turing.synth.81@example.test', '+9231000081') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '126 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 5', 'turing.synth.82@example.test', '+9231000082') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '167 days', now() - interval '164 days', NULL, now() - interval '158 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 5', 'turing.synth.83@example.test', '+9231000083') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '8 days', now() - interval '5 days', NULL, now() - interval '-1 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 5', 'turing.synth.84@example.test', '+9231000084') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '49 days', now() - interval '46 days', NULL, now() - interval '40 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 5', 'turing.synth.85@example.test', '+9231000085') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '90 days', now() - interval '87 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 5', 'turing.synth.86@example.test', '+9231000086') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '131 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 5', 'turing.synth.87@example.test', '+9231000087') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '172 days', now() - interval '169 days', NULL, now() - interval '163 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 5', 'turing.synth.88@example.test', '+9231000088') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '13 days', now() - interval '10 days', NULL, now() - interval '4 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 5', 'turing.synth.89@example.test', '+9231000089') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '54 days', now() - interval '51 days', NULL, now() - interval '45 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 5', 'turing.synth.90@example.test', '+9231000090') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '95 days', now() - interval '92 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 5', 'turing.synth.91@example.test', '+9231000091') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '136 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 5', 'turing.synth.92@example.test', '+9231000092') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '177 days', now() - interval '174 days', NULL, now() - interval '168 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 5', 'turing.synth.93@example.test', '+9231000093') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '18 days', now() - interval '15 days', NULL, now() - interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 5', 'turing.synth.94@example.test', '+9231000094') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '59 days', now() - interval '56 days', NULL, now() - interval '50 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 5', 'turing.synth.95@example.test', '+9231000095') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '100 days', now() - interval '97 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 5', 'turing.synth.96@example.test', '+9231000096') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '141 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 5', 'turing.synth.97@example.test', '+9231000097') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '182 days', now() - interval '179 days', NULL, now() - interval '173 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 5', 'turing.synth.98@example.test', '+9231000098') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '23 days', now() - interval '20 days', NULL, now() - interval '14 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 5', 'turing.synth.99@example.test', '+9231000099') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '64 days', now() - interval '61 days', NULL, now() - interval '55 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 6', 'turing.synth.100@example.test', '+9231000100') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '105 days', now() - interval '102 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 6', 'turing.synth.101@example.test', '+9231000101') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '146 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 6', 'turing.synth.102@example.test', '+9231000102') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '187 days', now() - interval '184 days', NULL, now() - interval '178 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 6', 'turing.synth.103@example.test', '+9231000103') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '28 days', now() - interval '25 days', NULL, now() - interval '19 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 6', 'turing.synth.104@example.test', '+9231000104') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '69 days', now() - interval '66 days', NULL, now() - interval '60 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 6', 'turing.synth.105@example.test', '+9231000105') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '110 days', now() - interval '107 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 6', 'turing.synth.106@example.test', '+9231000106') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '151 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 6', 'turing.synth.107@example.test', '+9231000107') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '192 days', now() - interval '189 days', NULL, now() - interval '183 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 6', 'turing.synth.108@example.test', '+9231000108') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '33 days', now() - interval '30 days', NULL, now() - interval '24 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 6', 'turing.synth.109@example.test', '+9231000109') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '74 days', now() - interval '71 days', NULL, now() - interval '65 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 6', 'turing.synth.110@example.test', '+9231000110') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '115 days', now() - interval '112 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 6', 'turing.synth.111@example.test', '+9231000111') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '156 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 6', 'turing.synth.112@example.test', '+9231000112') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '197 days', now() - interval '194 days', NULL, now() - interval '188 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 6', 'turing.synth.113@example.test', '+9231000113') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '38 days', now() - interval '35 days', NULL, now() - interval '29 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 6', 'turing.synth.114@example.test', '+9231000114') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '79 days', now() - interval '76 days', NULL, now() - interval '70 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 6', 'turing.synth.115@example.test', '+9231000115') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '120 days', now() - interval '117 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 6', 'turing.synth.116@example.test', '+9231000116') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '161 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 6', 'turing.synth.117@example.test', '+9231000117') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '202 days', now() - interval '199 days', NULL, now() - interval '193 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 6', 'turing.synth.118@example.test', '+9231000118') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '43 days', now() - interval '40 days', NULL, now() - interval '34 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 6', 'turing.synth.119@example.test', '+9231000119') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '84 days', now() - interval '81 days', NULL, now() - interval '75 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 7', 'turing.synth.120@example.test', '+9231000120') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '125 days', now() - interval '122 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 7', 'turing.synth.121@example.test', '+9231000121') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '166 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 7', 'turing.synth.122@example.test', '+9231000122') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '7 days', now() - interval '4 days', NULL, now() - interval '-2 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 7', 'turing.synth.123@example.test', '+9231000123') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '48 days', now() - interval '45 days', NULL, now() - interval '39 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 7', 'turing.synth.124@example.test', '+9231000124') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '89 days', now() - interval '86 days', NULL, now() - interval '80 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 7', 'turing.synth.125@example.test', '+9231000125') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '130 days', now() - interval '127 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 7', 'turing.synth.126@example.test', '+9231000126') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '171 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 7', 'turing.synth.127@example.test', '+9231000127') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '12 days', now() - interval '9 days', NULL, now() - interval '3 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 7', 'turing.synth.128@example.test', '+9231000128') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '53 days', now() - interval '50 days', NULL, now() - interval '44 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 7', 'turing.synth.129@example.test', '+9231000129') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '94 days', now() - interval '91 days', NULL, now() - interval '85 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 7', 'turing.synth.130@example.test', '+9231000130') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '135 days', now() - interval '132 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 7', 'turing.synth.131@example.test', '+9231000131') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '176 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 7', 'turing.synth.132@example.test', '+9231000132') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '17 days', now() - interval '14 days', NULL, now() - interval '8 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 7', 'turing.synth.133@example.test', '+9231000133') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '58 days', now() - interval '55 days', NULL, now() - interval '49 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 7', 'turing.synth.134@example.test', '+9231000134') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '99 days', now() - interval '96 days', NULL, now() - interval '90 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 7', 'turing.synth.135@example.test', '+9231000135') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '140 days', now() - interval '137 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 7', 'turing.synth.136@example.test', '+9231000136') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '181 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 7', 'turing.synth.137@example.test', '+9231000137') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '22 days', now() - interval '19 days', NULL, now() - interval '13 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 7', 'turing.synth.138@example.test', '+9231000138') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '63 days', now() - interval '60 days', NULL, now() - interval '54 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 7', 'turing.synth.139@example.test', '+9231000139') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '104 days', now() - interval '101 days', NULL, now() - interval '95 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 8', 'turing.synth.140@example.test', '+9231000140') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '145 days', now() - interval '142 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 8', 'turing.synth.141@example.test', '+9231000141') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '186 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 8', 'turing.synth.142@example.test', '+9231000142') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '27 days', now() - interval '24 days', NULL, now() - interval '18 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 8', 'turing.synth.143@example.test', '+9231000143') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '68 days', now() - interval '65 days', NULL, now() - interval '59 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 8', 'turing.synth.144@example.test', '+9231000144') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '109 days', now() - interval '106 days', NULL, now() - interval '100 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 8', 'turing.synth.145@example.test', '+9231000145') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '150 days', now() - interval '147 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 8', 'turing.synth.146@example.test', '+9231000146') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '191 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 8', 'turing.synth.147@example.test', '+9231000147') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '32 days', now() - interval '29 days', NULL, now() - interval '23 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 8', 'turing.synth.148@example.test', '+9231000148') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '73 days', now() - interval '70 days', NULL, now() - interval '64 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 8', 'turing.synth.149@example.test', '+9231000149') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '114 days', now() - interval '111 days', NULL, now() - interval '105 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 8', 'turing.synth.150@example.test', '+9231000150') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '155 days', now() - interval '152 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 8', 'turing.synth.151@example.test', '+9231000151') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '196 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 8', 'turing.synth.152@example.test', '+9231000152') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '37 days', now() - interval '34 days', NULL, now() - interval '28 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 8', 'turing.synth.153@example.test', '+9231000153') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '78 days', now() - interval '75 days', NULL, now() - interval '69 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 8', 'turing.synth.154@example.test', '+9231000154') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '119 days', now() - interval '116 days', NULL, now() - interval '110 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 8', 'turing.synth.155@example.test', '+9231000155') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '160 days', now() - interval '157 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 8', 'turing.synth.156@example.test', '+9231000156') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '201 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 8', 'turing.synth.157@example.test', '+9231000157') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '42 days', now() - interval '39 days', NULL, now() - interval '33 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 8', 'turing.synth.158@example.test', '+9231000158') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '83 days', now() - interval '80 days', NULL, now() - interval '74 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 8', 'turing.synth.159@example.test', '+9231000159') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '124 days', now() - interval '121 days', NULL, now() - interval '115 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 9', 'turing.synth.160@example.test', '+9231000160') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '165 days', now() - interval '162 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 9', 'turing.synth.161@example.test', '+9231000161') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '6 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 9', 'turing.synth.162@example.test', '+9231000162') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '47 days', now() - interval '44 days', NULL, now() - interval '38 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 9', 'turing.synth.163@example.test', '+9231000163') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '88 days', now() - interval '85 days', NULL, now() - interval '79 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 9', 'turing.synth.164@example.test', '+9231000164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '129 days', now() - interval '126 days', NULL, now() - interval '120 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 9', 'turing.synth.165@example.test', '+9231000165') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '170 days', now() - interval '167 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 9', 'turing.synth.166@example.test', '+9231000166') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '11 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 9', 'turing.synth.167@example.test', '+9231000167') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '52 days', now() - interval '49 days', NULL, now() - interval '43 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 9', 'turing.synth.168@example.test', '+9231000168') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '93 days', now() - interval '90 days', NULL, now() - interval '84 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 9', 'turing.synth.169@example.test', '+9231000169') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '134 days', now() - interval '131 days', NULL, now() - interval '125 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 9', 'turing.synth.170@example.test', '+9231000170') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '175 days', now() - interval '172 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 9', 'turing.synth.171@example.test', '+9231000171') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '16 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 9', 'turing.synth.172@example.test', '+9231000172') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '57 days', now() - interval '54 days', NULL, now() - interval '48 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 9', 'turing.synth.173@example.test', '+9231000173') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '98 days', now() - interval '95 days', NULL, now() - interval '89 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 9', 'turing.synth.174@example.test', '+9231000174') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '139 days', now() - interval '136 days', NULL, now() - interval '130 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 9', 'turing.synth.175@example.test', '+9231000175') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '180 days', now() - interval '177 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 9', 'turing.synth.176@example.test', '+9231000176') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '21 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 9', 'turing.synth.177@example.test', '+9231000177') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '62 days', now() - interval '59 days', NULL, now() - interval '53 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 9', 'turing.synth.178@example.test', '+9231000178') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '103 days', now() - interval '100 days', NULL, now() - interval '94 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 9', 'turing.synth.179@example.test', '+9231000179') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '144 days', now() - interval '141 days', NULL, now() - interval '135 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 10', 'turing.synth.180@example.test', '+9231000180') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '185 days', now() - interval '182 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 10', 'turing.synth.181@example.test', '+9231000181') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '26 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 10', 'turing.synth.182@example.test', '+9231000182') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '67 days', now() - interval '64 days', NULL, now() - interval '58 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 10', 'turing.synth.183@example.test', '+9231000183') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '108 days', now() - interval '105 days', NULL, now() - interval '99 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 10', 'turing.synth.184@example.test', '+9231000184') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '149 days', now() - interval '146 days', NULL, now() - interval '140 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 10', 'turing.synth.185@example.test', '+9231000185') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '190 days', now() - interval '187 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 10', 'turing.synth.186@example.test', '+9231000186') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '31 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 10', 'turing.synth.187@example.test', '+9231000187') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '72 days', now() - interval '69 days', NULL, now() - interval '63 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 10', 'turing.synth.188@example.test', '+9231000188') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '113 days', now() - interval '110 days', NULL, now() - interval '104 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 10', 'turing.synth.189@example.test', '+9231000189') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '154 days', now() - interval '151 days', NULL, now() - interval '145 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 10', 'turing.synth.190@example.test', '+9231000190') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '195 days', now() - interval '192 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 10', 'turing.synth.191@example.test', '+9231000191') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '36 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 10', 'turing.synth.192@example.test', '+9231000192') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '77 days', now() - interval '74 days', NULL, now() - interval '68 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 10', 'turing.synth.193@example.test', '+9231000193') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '118 days', now() - interval '115 days', NULL, now() - interval '109 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 10', 'turing.synth.194@example.test', '+9231000194') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '159 days', now() - interval '156 days', NULL, now() - interval '150 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 10', 'turing.synth.195@example.test', '+9231000195') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '200 days', now() - interval '197 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 10', 'turing.synth.196@example.test', '+9231000196') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '41 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 10', 'turing.synth.197@example.test', '+9231000197') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '82 days', now() - interval '79 days', NULL, now() - interval '73 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 10', 'turing.synth.198@example.test', '+9231000198') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '123 days', now() - interval '120 days', NULL, now() - interval '114 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 10', 'turing.synth.199@example.test', '+9231000199') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '164 days', now() - interval '161 days', NULL, now() - interval '155 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 11', 'turing.synth.200@example.test', '+9231000200') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '5 days', now() - interval '2 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 11', 'turing.synth.201@example.test', '+9231000201') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '46 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 11', 'turing.synth.202@example.test', '+9231000202') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '87 days', now() - interval '84 days', NULL, now() - interval '78 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 11', 'turing.synth.203@example.test', '+9231000203') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '128 days', now() - interval '125 days', NULL, now() - interval '119 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 11', 'turing.synth.204@example.test', '+9231000204') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '169 days', now() - interval '166 days', NULL, now() - interval '160 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 11', 'turing.synth.205@example.test', '+9231000205') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '10 days', now() - interval '7 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 11', 'turing.synth.206@example.test', '+9231000206') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '51 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 11', 'turing.synth.207@example.test', '+9231000207') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '92 days', now() - interval '89 days', NULL, now() - interval '83 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 11', 'turing.synth.208@example.test', '+9231000208') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '133 days', now() - interval '130 days', NULL, now() - interval '124 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 11', 'turing.synth.209@example.test', '+9231000209') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '174 days', now() - interval '171 days', NULL, now() - interval '165 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 11', 'turing.synth.210@example.test', '+9231000210') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '15 days', now() - interval '12 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 11', 'turing.synth.211@example.test', '+9231000211') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '56 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 11', 'turing.synth.212@example.test', '+9231000212') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '97 days', now() - interval '94 days', NULL, now() - interval '88 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 11', 'turing.synth.213@example.test', '+9231000213') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '138 days', now() - interval '135 days', NULL, now() - interval '129 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 11', 'turing.synth.214@example.test', '+9231000214') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '179 days', now() - interval '176 days', NULL, now() - interval '170 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 11', 'turing.synth.215@example.test', '+9231000215') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '20 days', now() - interval '17 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 11', 'turing.synth.216@example.test', '+9231000216') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '61 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 11', 'turing.synth.217@example.test', '+9231000217') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '102 days', now() - interval '99 days', NULL, now() - interval '93 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 11', 'turing.synth.218@example.test', '+9231000218') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '143 days', now() - interval '140 days', NULL, now() - interval '134 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 11', 'turing.synth.219@example.test', '+9231000219') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '184 days', now() - interval '181 days', NULL, now() - interval '175 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 12', 'turing.synth.220@example.test', '+9231000220') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '25 days', now() - interval '22 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 12', 'turing.synth.221@example.test', '+9231000221') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '66 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 12', 'turing.synth.222@example.test', '+9231000222') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '107 days', now() - interval '104 days', NULL, now() - interval '98 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 12', 'turing.synth.223@example.test', '+9231000223') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '148 days', now() - interval '145 days', NULL, now() - interval '139 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 12', 'turing.synth.224@example.test', '+9231000224') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '189 days', now() - interval '186 days', NULL, now() - interval '180 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 12', 'turing.synth.225@example.test', '+9231000225') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '30 days', now() - interval '27 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 12', 'turing.synth.226@example.test', '+9231000226') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '71 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 12', 'turing.synth.227@example.test', '+9231000227') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '112 days', now() - interval '109 days', NULL, now() - interval '103 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 12', 'turing.synth.228@example.test', '+9231000228') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '153 days', now() - interval '150 days', NULL, now() - interval '144 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 12', 'turing.synth.229@example.test', '+9231000229') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '194 days', now() - interval '191 days', NULL, now() - interval '185 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 12', 'turing.synth.230@example.test', '+9231000230') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '35 days', now() - interval '32 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 12', 'turing.synth.231@example.test', '+9231000231') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '76 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 12', 'turing.synth.232@example.test', '+9231000232') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '117 days', now() - interval '114 days', NULL, now() - interval '108 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 12', 'turing.synth.233@example.test', '+9231000233') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '158 days', now() - interval '155 days', NULL, now() - interval '149 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 12', 'turing.synth.234@example.test', '+9231000234') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '199 days', now() - interval '196 days', NULL, now() - interval '190 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 12', 'turing.synth.235@example.test', '+9231000235') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '40 days', now() - interval '37 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 12', 'turing.synth.236@example.test', '+9231000236') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '81 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 12', 'turing.synth.237@example.test', '+9231000237') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '122 days', now() - interval '119 days', NULL, now() - interval '113 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 12', 'turing.synth.238@example.test', '+9231000238') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '163 days', now() - interval '160 days', NULL, now() - interval '154 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 12', 'turing.synth.239@example.test', '+9231000239') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '204 days', now() - interval '201 days', NULL, now() - interval '195 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 13', 'turing.synth.240@example.test', '+9231000240') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '45 days', now() - interval '42 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 13', 'turing.synth.241@example.test', '+9231000241') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '86 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 13', 'turing.synth.242@example.test', '+9231000242') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '127 days', now() - interval '124 days', NULL, now() - interval '118 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 13', 'turing.synth.243@example.test', '+9231000243') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '168 days', now() - interval '165 days', NULL, now() - interval '159 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 13', 'turing.synth.244@example.test', '+9231000244') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '9 days', now() - interval '6 days', NULL, now() - interval '0 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 13', 'turing.synth.245@example.test', '+9231000245') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '50 days', now() - interval '47 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 13', 'turing.synth.246@example.test', '+9231000246') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '91 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 13', 'turing.synth.247@example.test', '+9231000247') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '132 days', now() - interval '129 days', NULL, now() - interval '123 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 13', 'turing.synth.248@example.test', '+9231000248') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '173 days', now() - interval '170 days', NULL, now() - interval '164 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 13', 'turing.synth.249@example.test', '+9231000249') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '14 days', now() - interval '11 days', NULL, now() - interval '5 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 13', 'turing.synth.250@example.test', '+9231000250') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '55 days', now() - interval '52 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 13', 'turing.synth.251@example.test', '+9231000251') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '96 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 13', 'turing.synth.252@example.test', '+9231000252') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '137 days', now() - interval '134 days', NULL, now() - interval '128 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 13', 'turing.synth.253@example.test', '+9231000253') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '178 days', now() - interval '175 days', NULL, now() - interval '169 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 13', 'turing.synth.254@example.test', '+9231000254') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '19 days', now() - interval '16 days', NULL, now() - interval '10 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 13', 'turing.synth.255@example.test', '+9231000255') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '60 days', now() - interval '57 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 13', 'turing.synth.256@example.test', '+9231000256') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '101 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 13', 'turing.synth.257@example.test', '+9231000257') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '142 days', now() - interval '139 days', NULL, now() - interval '133 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 13', 'turing.synth.258@example.test', '+9231000258') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '183 days', now() - interval '180 days', NULL, now() - interval '174 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 13', 'turing.synth.259@example.test', '+9231000259') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '24 days', now() - interval '21 days', NULL, now() - interval '15 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 14', 'turing.synth.260@example.test', '+9231000260') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '65 days', now() - interval '62 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 14', 'turing.synth.261@example.test', '+9231000261') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '106 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 14', 'turing.synth.262@example.test', '+9231000262') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '147 days', now() - interval '144 days', NULL, now() - interval '138 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 14', 'turing.synth.263@example.test', '+9231000263') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '188 days', now() - interval '185 days', NULL, now() - interval '179 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 14', 'turing.synth.264@example.test', '+9231000264') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '29 days', now() - interval '26 days', NULL, now() - interval '20 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 14', 'turing.synth.265@example.test', '+9231000265') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '70 days', now() - interval '67 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 14', 'turing.synth.266@example.test', '+9231000266') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '111 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 14', 'turing.synth.267@example.test', '+9231000267') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '152 days', now() - interval '149 days', NULL, now() - interval '143 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 14', 'turing.synth.268@example.test', '+9231000268') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '193 days', now() - interval '190 days', NULL, now() - interval '184 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 14', 'turing.synth.269@example.test', '+9231000269') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '34 days', now() - interval '31 days', NULL, now() - interval '25 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 14', 'turing.synth.270@example.test', '+9231000270') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '75 days', now() - interval '72 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 14', 'turing.synth.271@example.test', '+9231000271') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '116 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 14', 'turing.synth.272@example.test', '+9231000272') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '157 days', now() - interval '154 days', NULL, now() - interval '148 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 14', 'turing.synth.273@example.test', '+9231000273') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '198 days', now() - interval '195 days', NULL, now() - interval '189 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 14', 'turing.synth.274@example.test', '+9231000274') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '39 days', now() - interval '36 days', NULL, now() - interval '30 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 14', 'turing.synth.275@example.test', '+9231000275') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '80 days', now() - interval '77 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 14', 'turing.synth.276@example.test', '+9231000276') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '121 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 14', 'turing.synth.277@example.test', '+9231000277') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '162 days', now() - interval '159 days', NULL, now() - interval '153 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 14', 'turing.synth.278@example.test', '+9231000278') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '203 days', now() - interval '200 days', NULL, now() - interval '194 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 14', 'turing.synth.279@example.test', '+9231000279') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '44 days', now() - interval '41 days', NULL, now() - interval '35 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 15', 'turing.synth.280@example.test', '+9231000280') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '85 days', now() - interval '82 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 15', 'turing.synth.281@example.test', '+9231000281') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '126 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 15', 'turing.synth.282@example.test', '+9231000282') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '167 days', now() - interval '164 days', NULL, now() - interval '158 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 15', 'turing.synth.283@example.test', '+9231000283') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '8 days', now() - interval '5 days', NULL, now() - interval '-1 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 15', 'turing.synth.284@example.test', '+9231000284') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '49 days', now() - interval '46 days', NULL, now() - interval '40 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 15', 'turing.synth.285@example.test', '+9231000285') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '90 days', now() - interval '87 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 15', 'turing.synth.286@example.test', '+9231000286') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '131 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 15', 'turing.synth.287@example.test', '+9231000287') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '172 days', now() - interval '169 days', NULL, now() - interval '163 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 15', 'turing.synth.288@example.test', '+9231000288') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '13 days', now() - interval '10 days', NULL, now() - interval '4 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 15', 'turing.synth.289@example.test', '+9231000289') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '54 days', now() - interval '51 days', NULL, now() - interval '45 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 15', 'turing.synth.290@example.test', '+9231000290') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '95 days', now() - interval '92 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 15', 'turing.synth.291@example.test', '+9231000291') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '136 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 15', 'turing.synth.292@example.test', '+9231000292') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '177 days', now() - interval '174 days', NULL, now() - interval '168 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 15', 'turing.synth.293@example.test', '+9231000293') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '18 days', now() - interval '15 days', NULL, now() - interval '9 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 15', 'turing.synth.294@example.test', '+9231000294') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '59 days', now() - interval '56 days', NULL, now() - interval '50 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 15', 'turing.synth.295@example.test', '+9231000295') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '100 days', now() - interval '97 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 15', 'turing.synth.296@example.test', '+9231000296') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '141 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 15', 'turing.synth.297@example.test', '+9231000297') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '182 days', now() - interval '179 days', NULL, now() - interval '173 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 15', 'turing.synth.298@example.test', '+9231000298') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '23 days', now() - interval '20 days', NULL, now() - interval '14 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 15', 'turing.synth.299@example.test', '+9231000299') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '64 days', now() - interval '61 days', NULL, now() - interval '55 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 16', 'turing.synth.300@example.test', '+9231000300') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '105 days', now() - interval '102 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 16', 'turing.synth.301@example.test', '+9231000301') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '146 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 16', 'turing.synth.302@example.test', '+9231000302') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '187 days', now() - interval '184 days', NULL, now() - interval '178 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 16', 'turing.synth.303@example.test', '+9231000303') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '28 days', now() - interval '25 days', NULL, now() - interval '19 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 16', 'turing.synth.304@example.test', '+9231000304') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '69 days', now() - interval '66 days', NULL, now() - interval '60 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 16', 'turing.synth.305@example.test', '+9231000305') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '110 days', now() - interval '107 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 16', 'turing.synth.306@example.test', '+9231000306') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '151 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 16', 'turing.synth.307@example.test', '+9231000307') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '192 days', now() - interval '189 days', NULL, now() - interval '183 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 16', 'turing.synth.308@example.test', '+9231000308') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '33 days', now() - interval '30 days', NULL, now() - interval '24 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 16', 'turing.synth.309@example.test', '+9231000309') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '74 days', now() - interval '71 days', NULL, now() - interval '65 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 16', 'turing.synth.310@example.test', '+9231000310') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '115 days', now() - interval '112 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 16', 'turing.synth.311@example.test', '+9231000311') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '156 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 16', 'turing.synth.312@example.test', '+9231000312') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '197 days', now() - interval '194 days', NULL, now() - interval '188 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 16', 'turing.synth.313@example.test', '+9231000313') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '38 days', now() - interval '35 days', NULL, now() - interval '29 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 16', 'turing.synth.314@example.test', '+9231000314') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '79 days', now() - interval '76 days', NULL, now() - interval '70 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 16', 'turing.synth.315@example.test', '+9231000315') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '120 days', now() - interval '117 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 16', 'turing.synth.316@example.test', '+9231000316') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '161 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 16', 'turing.synth.317@example.test', '+9231000317') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Technical Content Writer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '202 days', now() - interval '199 days', NULL, now() - interval '193 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 16', 'turing.synth.318@example.test', '+9231000318') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotaor Ubuntu Desktop operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '43 days', now() - interval '40 days', NULL, now() - interval '34 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 16', 'turing.synth.319@example.test', '+9231000319') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Image / Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '84 days', now() - interval '81 days', NULL, now() - interval '75 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 17', 'turing.synth.320@example.test', '+9231000320') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '125 days', now() - interval '122 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 17', 'turing.synth.321@example.test', '+9231000321') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Docker file Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '166 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 17', 'turing.synth.322@example.test', '+9231000322') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Annotator ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '7 days', now() - interval '4 days', NULL, now() - interval '-2 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 17', 'turing.synth.323@example.test', '+9231000323') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '48 days', now() - interval '45 days', NULL, now() - interval '39 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 17', 'turing.synth.324@example.test', '+9231000324') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker Exerience';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '89 days', now() - interval '86 days', NULL, now() - interval '80 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 17', 'turing.synth.325@example.test', '+9231000325') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Dockerfile Data validation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '130 days', now() - interval '127 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 17', 'turing.synth.326@example.test', '+9231000326') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Bench Mark engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '171 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 17', 'turing.synth.327@example.test', '+9231000327') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Terminal Bench (Python & Linux system)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '12 days', now() - interval '9 days', NULL, now() - interval '3 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 17', 'turing.synth.328@example.test', '+9231000328') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Small business Owner AI response AI evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '53 days', now() - interval '50 days', NULL, now() - interval '44 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 17', 'turing.synth.329@example.test', '+9231000329') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Creative Software specialist ( Open source Tools)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '94 days', now() - interval '91 days', NULL, now() - interval '85 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 17', 'turing.synth.330@example.test', '+9231000330') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM -Trainer Agent Function call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '135 days', now() - interval '132 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 17', 'turing.synth.331@example.test', '+9231000331') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '176 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 17', 'turing.synth.332@example.test', '+9231000332') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI Trainer Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '17 days', now() - interval '14 days', NULL, now() - interval '8 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 17', 'turing.synth.333@example.test', '+9231000333') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '58 days', now() - interval '55 days', NULL, now() - interval '49 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 17', 'turing.synth.334@example.test', '+9231000334') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '99 days', now() - interval '96 days', NULL, now() - interval '90 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 17', 'turing.synth.335@example.test', '+9231000335') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '140 days', now() - interval '137 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 17', 'turing.synth.336@example.test', '+9231000336') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI quality Analyst  English';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '181 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 17', 'turing.synth.337@example.test', '+9231000337') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S3 Annotator (Open Claw Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '22 days', now() - interval '19 days', NULL, now() - interval '13 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Aditya', 'Kumar 17', 'turing.synth.338@example.test', '+9231000338') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Software Engineer With Python and Docker';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '63 days', now() - interval '60 days', NULL, now() - interval '54 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Divya', 'Menon 17', 'turing.synth.339@example.test', '+9231000339') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Mathematics Expert PH.d';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '104 days', now() - interval '101 days', NULL, now() - interval '95 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thabo', 'Nkosi 18', 'turing.synth.340@example.test', '+9231000340') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Software Engineer SWE';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '145 days', now() - interval '142 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lindiwe', 'Dlamini 18', 'turing.synth.341@example.test', '+9231000341') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Tax Form Expert';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '186 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 18', 'turing.synth.342@example.test', '+9231000342') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Anotator Ubuntu Desktop Operator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '27 days', now() - interval '24 days', NULL, now() - interval '18 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Naledi', 'Mokoena 18', 'turing.synth.343@example.test', '+9231000343') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '68 days', now() - interval '65 days', NULL, now() - interval '59 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Bongani', 'Zulu 18', 'turing.synth.344@example.test', '+9231000344') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Video Data Annotator';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '109 days', now() - interval '106 days', NULL, now() - interval '100 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Amahle', 'Mthembu 18', 'turing.synth.345@example.test', '+9231000345') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Business Analyst (RLHF/  Analyst )';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '150 days', now() - interval '147 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kagiso', 'Sithole 18', 'turing.synth.346@example.test', '+9231000346') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM S2 Annotator (CUA Trajectory Specialist)';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '191 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Nomvula', 'Khoza 18', 'turing.synth.347@example.test', '+9231000347') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Agentic Coding Annotator Online/ Offline Tasks';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '32 days', now() - interval '29 days', NULL, now() - interval '23 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Johan', 'van der Merwe 18', 'turing.synth.348@example.test', '+9231000348') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Gaming Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '73 days', now() - interval '70 days', NULL, now() - interval '64 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 18', 'turing.synth.349@example.test', '+9231000349') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '114 days', now() - interval '111 days', NULL, now() - interval '105 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rahul', 'Verma 18', 'turing.synth.350@example.test', '+9231000350') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI safety and Policy Analyst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '155 days', now() - interval '152 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 18', 'turing.synth.351@example.test', '+9231000351') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Data Science /Anlayst';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '196 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Vikram', 'Singh 18', 'turing.synth.352@example.test', '+9231000352') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'AI trainer Agent Function Call';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '37 days', now() - interval '34 days', NULL, now() - interval '28 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Neha', 'Gupta 18', 'turing.synth.353@example.test', '+9231000353') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Anas Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Text 2SQL Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '78 days', now() - interval '75 days', NULL, now() - interval '69 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 18', 'turing.synth.354@example.test', '+9231000354') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Urwa Hafeez';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Astronomical Computation Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '119 days', now() - interval '116 days', NULL, now() - interval '110 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Kavya', 'Nair 18', 'turing.synth.355@example.test', '+9231000355') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Hanzala';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Python Reviwer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'applied', now() - interval '160 days', now() - interval '157 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta 18', 'turing.synth.356@example.test', '+9231000356') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Haider';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'LLM Data quality and tooling Specialist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'referred', now() - interval '201 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sneha', 'Patel 18', 'turing.synth.357@example.test', '+9231000357') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = turing_id AND name = 'Momina Saleem';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND title = 'Senior Software Engineer- LLM Evaluation';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, turing_id, v_acct_id, v_job_id, 'not_hired', now() - interval '42 days', now() - interval '39 days', NULL, now() - interval '33 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez', 'marcor.synth.0@example.test', '+9231000000') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '5 days', now() - interval '2 days', now() - interval '-5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Gonzalez', 'marcor.synth.1@example.test', '+9231000001') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '46 days', now() - interval '43 days', now() - interval '36 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Martinez', 'marcor.synth.2@example.test', '+9231000002') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '87 days', now() - interval '84 days', now() - interval '77 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez', 'marcor.synth.3@example.test', '+9231000003') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '128 days', now() - interval '125 days', now() - interval '118 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez', 'marcor.synth.4@example.test', '+9231000004') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '169 days', now() - interval '166 days', now() - interval '159 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Torres', 'marcor.synth.5@example.test', '+9231000005') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '10 days', now() - interval '7 days', now() - interval '0 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Michael', 'Johnson', 'marcor.synth.6@example.test', '+9231000006') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '51 days', now() - interval '48 days', now() - interval '41 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis', 'marcor.synth.7@example.test', '+9231000007') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '92 days', now() - interval '89 days', now() - interval '82 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Wilson', 'marcor.synth.8@example.test', '+9231000008') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '133 days', now() - interval '130 days', now() - interval '123 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jessica', 'Brown', 'marcor.synth.9@example.test', '+9231000009') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '174 days', now() - interval '171 days', now() - interval '164 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Miller', 'marcor.synth.10@example.test', '+9231000010') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '15 days', now() - interval '12 days', now() - interval '5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller', 'marcor.synth.11@example.test', '+9231000011') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '56 days', now() - interval '53 days', now() - interval '46 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emma', 'Dubois', 'marcor.synth.12@example.test', '+9231000012') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '97 days', now() - interval '94 days', now() - interval '87 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi', 'marcor.synth.13@example.test', '+9231000013') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '138 days', now() - interval '135 days', now() - interval '128 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anna', 'Kowalski', 'marcor.synth.14@example.test', '+9231000014') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '179 days', now() - interval '176 days', now() - interval '169 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Erik', 'Andersson', 'marcor.synth.15@example.test', '+9231000015') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '20 days', now() - interval '17 days', now() - interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Silva', 'marcor.synth.16@example.test', '+9231000016') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '61 days', now() - interval '58 days', now() - interval '51 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mateo', 'Herrera', 'marcor.synth.17@example.test', '+9231000017') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '102 days', now() - interval '99 days', now() - interval '92 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Isabella', 'Cruz', 'marcor.synth.18@example.test', '+9231000018') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '143 days', now() - interval '140 days', now() - interval '133 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thomas', 'Weber', 'marcor.synth.19@example.test', '+9231000019') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'hired', now() - interval '184 days', now() - interval '181 days', now() - interval '174 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 2', 'marcor.synth.20@example.test', '+9231000020') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '25 days', now() - interval '22 days', NULL, now() - interval '16 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Gonzalez 2', 'marcor.synth.21@example.test', '+9231000021') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '66 days', now() - interval '63 days', NULL, now() - interval '57 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Martinez 2', 'marcor.synth.22@example.test', '+9231000022') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '107 days', now() - interval '104 days', NULL, now() - interval '98 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 2', 'marcor.synth.23@example.test', '+9231000023') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '148 days', now() - interval '145 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 2', 'marcor.synth.24@example.test', '+9231000024') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '189 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Torres 2', 'marcor.synth.25@example.test', '+9231000025') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '30 days', now() - interval '27 days', NULL, now() - interval '21 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Michael', 'Johnson 2', 'marcor.synth.26@example.test', '+9231000026') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '71 days', now() - interval '68 days', NULL, now() - interval '62 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 2', 'marcor.synth.27@example.test', '+9231000027') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '112 days', now() - interval '109 days', NULL, now() - interval '103 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Wilson 2', 'marcor.synth.28@example.test', '+9231000028') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '153 days', now() - interval '150 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jessica', 'Brown 2', 'marcor.synth.29@example.test', '+9231000029') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '194 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Miller 2', 'marcor.synth.30@example.test', '+9231000030') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '35 days', now() - interval '32 days', NULL, now() - interval '26 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 2', 'marcor.synth.31@example.test', '+9231000031') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '76 days', now() - interval '73 days', NULL, now() - interval '67 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emma', 'Dubois 2', 'marcor.synth.32@example.test', '+9231000032') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '117 days', now() - interval '114 days', NULL, now() - interval '108 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 2', 'marcor.synth.33@example.test', '+9231000033') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '158 days', now() - interval '155 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anna', 'Kowalski 2', 'marcor.synth.34@example.test', '+9231000034') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '199 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Erik', 'Andersson 2', 'marcor.synth.35@example.test', '+9231000035') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '40 days', now() - interval '37 days', NULL, now() - interval '31 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Silva 2', 'marcor.synth.36@example.test', '+9231000036') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '81 days', now() - interval '78 days', NULL, now() - interval '72 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mateo', 'Herrera 2', 'marcor.synth.37@example.test', '+9231000037') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '122 days', now() - interval '119 days', NULL, now() - interval '113 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Isabella', 'Cruz 2', 'marcor.synth.38@example.test', '+9231000038') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '163 days', now() - interval '160 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thomas', 'Weber 2', 'marcor.synth.39@example.test', '+9231000039') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '204 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 3', 'marcor.synth.40@example.test', '+9231000040') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '45 days', now() - interval '42 days', NULL, now() - interval '36 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Gonzalez 3', 'marcor.synth.41@example.test', '+9231000041') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '86 days', now() - interval '83 days', NULL, now() - interval '77 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Martinez 3', 'marcor.synth.42@example.test', '+9231000042') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '127 days', now() - interval '124 days', NULL, now() - interval '118 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 3', 'marcor.synth.43@example.test', '+9231000043') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '168 days', now() - interval '165 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 3', 'marcor.synth.44@example.test', '+9231000044') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '9 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Torres 3', 'marcor.synth.45@example.test', '+9231000045') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '50 days', now() - interval '47 days', NULL, now() - interval '41 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Michael', 'Johnson 3', 'marcor.synth.46@example.test', '+9231000046') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '91 days', now() - interval '88 days', NULL, now() - interval '82 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 3', 'marcor.synth.47@example.test', '+9231000047') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '132 days', now() - interval '129 days', NULL, now() - interval '123 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Wilson 3', 'marcor.synth.48@example.test', '+9231000048') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '173 days', now() - interval '170 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jessica', 'Brown 3', 'marcor.synth.49@example.test', '+9231000049') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '14 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Miller 3', 'marcor.synth.50@example.test', '+9231000050') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '55 days', now() - interval '52 days', NULL, now() - interval '46 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 3', 'marcor.synth.51@example.test', '+9231000051') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '96 days', now() - interval '93 days', NULL, now() - interval '87 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emma', 'Dubois 3', 'marcor.synth.52@example.test', '+9231000052') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '137 days', now() - interval '134 days', NULL, now() - interval '128 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 3', 'marcor.synth.53@example.test', '+9231000053') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '178 days', now() - interval '175 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anna', 'Kowalski 3', 'marcor.synth.54@example.test', '+9231000054') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '19 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Erik', 'Andersson 3', 'marcor.synth.55@example.test', '+9231000055') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '60 days', now() - interval '57 days', NULL, now() - interval '51 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Silva 3', 'marcor.synth.56@example.test', '+9231000056') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '101 days', now() - interval '98 days', NULL, now() - interval '92 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mateo', 'Herrera 3', 'marcor.synth.57@example.test', '+9231000057') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '142 days', now() - interval '139 days', NULL, now() - interval '133 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Isabella', 'Cruz 3', 'marcor.synth.58@example.test', '+9231000058') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '183 days', now() - interval '180 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thomas', 'Weber 3', 'marcor.synth.59@example.test', '+9231000059') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '24 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 4', 'marcor.synth.60@example.test', '+9231000060') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '65 days', now() - interval '62 days', NULL, now() - interval '56 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Maria', 'Gonzalez 4', 'marcor.synth.61@example.test', '+9231000061') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '106 days', now() - interval '103 days', NULL, now() - interval '97 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Juan', 'Martinez 4', 'marcor.synth.62@example.test', '+9231000062') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '147 days', now() - interval '144 days', NULL, now() - interval '138 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 4', 'marcor.synth.63@example.test', '+9231000063') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '188 days', now() - interval '185 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 4', 'marcor.synth.64@example.test', '+9231000064') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '29 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Valentina', 'Torres 4', 'marcor.synth.65@example.test', '+9231000065') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '70 days', now() - interval '67 days', NULL, now() - interval '61 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Michael', 'Johnson 4', 'marcor.synth.66@example.test', '+9231000066') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '111 days', now() - interval '108 days', NULL, now() - interval '102 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 4', 'marcor.synth.67@example.test', '+9231000067') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '152 days', now() - interval '149 days', NULL, now() - interval '143 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Chris', 'Wilson 4', 'marcor.synth.68@example.test', '+9231000068') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '193 days', now() - interval '190 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jessica', 'Brown 4', 'marcor.synth.69@example.test', '+9231000069') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '34 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('David', 'Miller 4', 'marcor.synth.70@example.test', '+9231000070') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '75 days', now() - interval '72 days', NULL, now() - interval '66 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 4', 'marcor.synth.71@example.test', '+9231000071') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '116 days', now() - interval '113 days', NULL, now() - interval '107 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emma', 'Dubois 4', 'marcor.synth.72@example.test', '+9231000072') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '157 days', now() - interval '154 days', NULL, now() - interval '148 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 4', 'marcor.synth.73@example.test', '+9231000073') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '198 days', now() - interval '195 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Anna', 'Kowalski 4', 'marcor.synth.74@example.test', '+9231000074') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '39 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Erik', 'Andersson 4', 'marcor.synth.75@example.test', '+9231000075') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '80 days', now() - interval '77 days', NULL, now() - interval '71 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Camila', 'Silva 4', 'marcor.synth.76@example.test', '+9231000076') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '121 days', now() - interval '118 days', NULL, now() - interval '112 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mateo', 'Herrera 4', 'marcor.synth.77@example.test', '+9231000077') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'not_hired', now() - interval '162 days', now() - interval '159 days', NULL, now() - interval '153 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Isabella', 'Cruz 4', 'marcor.synth.78@example.test', '+9231000078') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'Data Scientist';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'applied', now() - interval '203 days', now() - interval '200 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Thomas', 'Weber 4', 'marcor.synth.79@example.test', '+9231000079') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = marcor_id AND name = 'Marcor Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = marcor_id AND title = 'DevOps Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, marcor_id, v_acct_id, v_job_id, 'referred', now() - interval '44 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen', 'micro1.synth.0@example.test', '+9231000000') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '5 days', now() - interval '2 days', now() - interval '-5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka', 'micro1.synth.1@example.test', '+9231000001') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '46 days', now() - interval '43 days', now() - interval '36 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed', 'micro1.synth.2@example.test', '+9231000002') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '87 days', now() - interval '84 days', now() - interval '77 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan', 'micro1.synth.3@example.test', '+9231000003') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '128 days', now() - interval '125 days', now() - interval '118 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor', 'micro1.synth.4@example.test', '+9231000004') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '169 days', now() - interval '166 days', now() - interval '159 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma', 'micro1.synth.5@example.test', '+9231000005') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '10 days', now() - interval '7 days', now() - interval '0 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez', 'micro1.synth.6@example.test', '+9231000006') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '51 days', now() - interval '48 days', now() - interval '41 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller', 'micro1.synth.7@example.test', '+9231000007') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '92 days', now() - interval '89 days', now() - interval '82 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo', 'micro1.synth.8@example.test', '+9231000008') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '133 days', now() - interval '130 days', now() - interval '123 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis', 'micro1.synth.9@example.test', '+9231000009') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '174 days', now() - interval '171 days', now() - interval '164 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid', 'micro1.synth.10@example.test', '+9231000010') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '15 days', now() - interval '12 days', now() - interval '5 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin', 'micro1.synth.11@example.test', '+9231000011') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '56 days', now() - interval '53 days', now() - interval '46 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei', 'micro1.synth.12@example.test', '+9231000012') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '97 days', now() - interval '94 days', now() - interval '87 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez', 'micro1.synth.13@example.test', '+9231000013') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '138 days', now() - interval '135 days', now() - interval '128 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy', 'micro1.synth.14@example.test', '+9231000014') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '179 days', now() - interval '176 days', now() - interval '169 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim', 'micro1.synth.15@example.test', '+9231000015') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '20 days', now() - interval '17 days', now() - interval '10 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim', 'micro1.synth.16@example.test', '+9231000016') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '61 days', now() - interval '58 days', now() - interval '51 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi', 'micro1.synth.17@example.test', '+9231000017') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '102 days', now() - interval '99 days', now() - interval '92 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer', 'micro1.synth.18@example.test', '+9231000018') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '143 days', now() - interval '140 days', now() - interval '133 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez', 'micro1.synth.19@example.test', '+9231000019') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '184 days', now() - interval '181 days', now() - interval '174 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 2', 'micro1.synth.20@example.test', '+9231000020') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '25 days', now() - interval '22 days', now() - interval '15 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 2', 'micro1.synth.21@example.test', '+9231000021') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '66 days', now() - interval '63 days', now() - interval '56 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 2', 'micro1.synth.22@example.test', '+9231000022') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '107 days', now() - interval '104 days', now() - interval '97 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 2', 'micro1.synth.23@example.test', '+9231000023') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '148 days', now() - interval '145 days', now() - interval '138 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 2', 'micro1.synth.24@example.test', '+9231000024') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '189 days', now() - interval '186 days', now() - interval '179 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 2', 'micro1.synth.25@example.test', '+9231000025') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '30 days', now() - interval '27 days', now() - interval '20 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 2', 'micro1.synth.26@example.test', '+9231000026') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '71 days', now() - interval '68 days', now() - interval '61 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 2', 'micro1.synth.27@example.test', '+9231000027') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '112 days', now() - interval '109 days', now() - interval '102 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 2', 'micro1.synth.28@example.test', '+9231000028') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '153 days', now() - interval '150 days', now() - interval '143 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 2', 'micro1.synth.29@example.test', '+9231000029') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '194 days', now() - interval '191 days', now() - interval '184 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 2', 'micro1.synth.30@example.test', '+9231000030') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '35 days', now() - interval '32 days', now() - interval '25 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 2', 'micro1.synth.31@example.test', '+9231000031') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '76 days', now() - interval '73 days', now() - interval '66 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 2', 'micro1.synth.32@example.test', '+9231000032') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '117 days', now() - interval '114 days', now() - interval '107 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 2', 'micro1.synth.33@example.test', '+9231000033') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '158 days', now() - interval '155 days', now() - interval '148 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 2', 'micro1.synth.34@example.test', '+9231000034') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '199 days', now() - interval '196 days', now() - interval '189 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 2', 'micro1.synth.35@example.test', '+9231000035') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '40 days', now() - interval '37 days', now() - interval '30 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 2', 'micro1.synth.36@example.test', '+9231000036') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '81 days', now() - interval '78 days', now() - interval '71 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 2', 'micro1.synth.37@example.test', '+9231000037') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '122 days', now() - interval '119 days', now() - interval '112 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 2', 'micro1.synth.38@example.test', '+9231000038') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '163 days', now() - interval '160 days', now() - interval '153 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 2', 'micro1.synth.39@example.test', '+9231000039') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '204 days', now() - interval '201 days', now() - interval '194 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 3', 'micro1.synth.40@example.test', '+9231000040') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '45 days', now() - interval '42 days', now() - interval '35 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 3', 'micro1.synth.41@example.test', '+9231000041') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '86 days', now() - interval '83 days', now() - interval '76 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 3', 'micro1.synth.42@example.test', '+9231000042') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '127 days', now() - interval '124 days', now() - interval '117 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 3', 'micro1.synth.43@example.test', '+9231000043') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '168 days', now() - interval '165 days', now() - interval '158 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 3', 'micro1.synth.44@example.test', '+9231000044') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '9 days', now() - interval '6 days', now() - interval '-1 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 3', 'micro1.synth.45@example.test', '+9231000045') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '50 days', now() - interval '47 days', now() - interval '40 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 3', 'micro1.synth.46@example.test', '+9231000046') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '91 days', now() - interval '88 days', now() - interval '81 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 3', 'micro1.synth.47@example.test', '+9231000047') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '132 days', now() - interval '129 days', now() - interval '122 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 3', 'micro1.synth.48@example.test', '+9231000048') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '173 days', now() - interval '170 days', now() - interval '163 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 3', 'micro1.synth.49@example.test', '+9231000049') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '14 days', now() - interval '11 days', now() - interval '4 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 3', 'micro1.synth.50@example.test', '+9231000050') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '55 days', now() - interval '52 days', now() - interval '45 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 3', 'micro1.synth.51@example.test', '+9231000051') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '96 days', now() - interval '93 days', now() - interval '86 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 3', 'micro1.synth.52@example.test', '+9231000052') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '137 days', now() - interval '134 days', now() - interval '127 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 3', 'micro1.synth.53@example.test', '+9231000053') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '178 days', now() - interval '175 days', now() - interval '168 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 3', 'micro1.synth.54@example.test', '+9231000054') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '19 days', now() - interval '16 days', now() - interval '9 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 3', 'micro1.synth.55@example.test', '+9231000055') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '60 days', now() - interval '57 days', now() - interval '50 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 3', 'micro1.synth.56@example.test', '+9231000056') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '101 days', now() - interval '98 days', now() - interval '91 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 3', 'micro1.synth.57@example.test', '+9231000057') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '142 days', now() - interval '139 days', now() - interval '132 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 3', 'micro1.synth.58@example.test', '+9231000058') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '183 days', now() - interval '180 days', now() - interval '173 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 3', 'micro1.synth.59@example.test', '+9231000059') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '24 days', now() - interval '21 days', now() - interval '14 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 4', 'micro1.synth.60@example.test', '+9231000060') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '65 days', now() - interval '62 days', now() - interval '55 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 4', 'micro1.synth.61@example.test', '+9231000061') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '106 days', now() - interval '103 days', now() - interval '96 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 4', 'micro1.synth.62@example.test', '+9231000062') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '147 days', now() - interval '144 days', now() - interval '137 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 4', 'micro1.synth.63@example.test', '+9231000063') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '188 days', now() - interval '185 days', now() - interval '178 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 4', 'micro1.synth.64@example.test', '+9231000064') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '29 days', now() - interval '26 days', now() - interval '19 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 4', 'micro1.synth.65@example.test', '+9231000065') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '70 days', now() - interval '67 days', now() - interval '60 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 4', 'micro1.synth.66@example.test', '+9231000066') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '111 days', now() - interval '108 days', now() - interval '101 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 4', 'micro1.synth.67@example.test', '+9231000067') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '152 days', now() - interval '149 days', now() - interval '142 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 4', 'micro1.synth.68@example.test', '+9231000068') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '193 days', now() - interval '190 days', now() - interval '183 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 4', 'micro1.synth.69@example.test', '+9231000069') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '34 days', now() - interval '31 days', now() - interval '24 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 4', 'micro1.synth.70@example.test', '+9231000070') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '75 days', now() - interval '72 days', now() - interval '65 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 4', 'micro1.synth.71@example.test', '+9231000071') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '116 days', now() - interval '113 days', now() - interval '106 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 4', 'micro1.synth.72@example.test', '+9231000072') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '157 days', now() - interval '154 days', now() - interval '147 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 4', 'micro1.synth.73@example.test', '+9231000073') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '198 days', now() - interval '195 days', now() - interval '188 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 4', 'micro1.synth.74@example.test', '+9231000074') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '39 days', now() - interval '36 days', now() - interval '29 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 4', 'micro1.synth.75@example.test', '+9231000075') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '80 days', now() - interval '77 days', now() - interval '70 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 4', 'micro1.synth.76@example.test', '+9231000076') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '121 days', now() - interval '118 days', now() - interval '111 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 4', 'micro1.synth.77@example.test', '+9231000077') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '162 days', now() - interval '159 days', now() - interval '152 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 4', 'micro1.synth.78@example.test', '+9231000078') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '203 days', now() - interval '200 days', now() - interval '193 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 4', 'micro1.synth.79@example.test', '+9231000079') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '44 days', now() - interval '41 days', now() - interval '34 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 5', 'micro1.synth.80@example.test', '+9231000080') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '85 days', now() - interval '82 days', now() - interval '75 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 5', 'micro1.synth.81@example.test', '+9231000081') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '126 days', now() - interval '123 days', now() - interval '116 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 5', 'micro1.synth.82@example.test', '+9231000082') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '167 days', now() - interval '164 days', now() - interval '157 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 5', 'micro1.synth.83@example.test', '+9231000083') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '8 days', now() - interval '5 days', now() - interval '-2 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 5', 'micro1.synth.84@example.test', '+9231000084') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '49 days', now() - interval '46 days', now() - interval '39 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 5', 'micro1.synth.85@example.test', '+9231000085') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '90 days', now() - interval '87 days', now() - interval '80 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 5', 'micro1.synth.86@example.test', '+9231000086') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '131 days', now() - interval '128 days', now() - interval '121 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 5', 'micro1.synth.87@example.test', '+9231000087') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '172 days', now() - interval '169 days', now() - interval '162 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 5', 'micro1.synth.88@example.test', '+9231000088') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '13 days', now() - interval '10 days', now() - interval '3 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 5', 'micro1.synth.89@example.test', '+9231000089') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '54 days', now() - interval '51 days', now() - interval '44 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 5', 'micro1.synth.90@example.test', '+9231000090') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '95 days', now() - interval '92 days', now() - interval '85 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 5', 'micro1.synth.91@example.test', '+9231000091') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '136 days', now() - interval '133 days', now() - interval '126 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 5', 'micro1.synth.92@example.test', '+9231000092') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '177 days', now() - interval '174 days', now() - interval '167 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 5', 'micro1.synth.93@example.test', '+9231000093') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '18 days', now() - interval '15 days', now() - interval '8 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 5', 'micro1.synth.94@example.test', '+9231000094') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '59 days', now() - interval '56 days', now() - interval '49 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 5', 'micro1.synth.95@example.test', '+9231000095') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '100 days', now() - interval '97 days', now() - interval '90 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 5', 'micro1.synth.96@example.test', '+9231000096') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '141 days', now() - interval '138 days', now() - interval '131 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 5', 'micro1.synth.97@example.test', '+9231000097') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'hired', now() - interval '182 days', now() - interval '179 days', now() - interval '172 days', NULL, 10)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 5', 'micro1.synth.98@example.test', '+9231000098') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '23 days', now() - interval '20 days', NULL, now() - interval '14 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 5', 'micro1.synth.99@example.test', '+9231000099') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '64 days', now() - interval '61 days', NULL, now() - interval '55 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 6', 'micro1.synth.100@example.test', '+9231000100') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '105 days', now() - interval '102 days', NULL, now() - interval '96 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 6', 'micro1.synth.101@example.test', '+9231000101') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '146 days', now() - interval '143 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 6', 'micro1.synth.102@example.test', '+9231000102') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '187 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 6', 'micro1.synth.103@example.test', '+9231000103') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '28 days', now() - interval '25 days', NULL, now() - interval '19 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 6', 'micro1.synth.104@example.test', '+9231000104') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '69 days', now() - interval '66 days', NULL, now() - interval '60 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 6', 'micro1.synth.105@example.test', '+9231000105') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '110 days', now() - interval '107 days', NULL, now() - interval '101 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 6', 'micro1.synth.106@example.test', '+9231000106') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '151 days', now() - interval '148 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 6', 'micro1.synth.107@example.test', '+9231000107') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '192 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 6', 'micro1.synth.108@example.test', '+9231000108') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '33 days', now() - interval '30 days', NULL, now() - interval '24 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 6', 'micro1.synth.109@example.test', '+9231000109') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '74 days', now() - interval '71 days', NULL, now() - interval '65 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 6', 'micro1.synth.110@example.test', '+9231000110') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '115 days', now() - interval '112 days', NULL, now() - interval '106 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 6', 'micro1.synth.111@example.test', '+9231000111') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '156 days', now() - interval '153 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 6', 'micro1.synth.112@example.test', '+9231000112') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '197 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 6', 'micro1.synth.113@example.test', '+9231000113') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '38 days', now() - interval '35 days', NULL, now() - interval '29 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 6', 'micro1.synth.114@example.test', '+9231000114') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '79 days', now() - interval '76 days', NULL, now() - interval '70 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 6', 'micro1.synth.115@example.test', '+9231000115') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '120 days', now() - interval '117 days', NULL, now() - interval '111 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 6', 'micro1.synth.116@example.test', '+9231000116') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '161 days', now() - interval '158 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 6', 'micro1.synth.117@example.test', '+9231000117') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '202 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 6', 'micro1.synth.118@example.test', '+9231000118') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '43 days', now() - interval '40 days', NULL, now() - interval '34 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 6', 'micro1.synth.119@example.test', '+9231000119') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '84 days', now() - interval '81 days', NULL, now() - interval '75 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 7', 'micro1.synth.120@example.test', '+9231000120') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '125 days', now() - interval '122 days', NULL, now() - interval '116 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 7', 'micro1.synth.121@example.test', '+9231000121') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '166 days', now() - interval '163 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 7', 'micro1.synth.122@example.test', '+9231000122') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '7 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 7', 'micro1.synth.123@example.test', '+9231000123') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '48 days', now() - interval '45 days', NULL, now() - interval '39 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 7', 'micro1.synth.124@example.test', '+9231000124') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '89 days', now() - interval '86 days', NULL, now() - interval '80 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 7', 'micro1.synth.125@example.test', '+9231000125') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '130 days', now() - interval '127 days', NULL, now() - interval '121 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 7', 'micro1.synth.126@example.test', '+9231000126') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '171 days', now() - interval '168 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 7', 'micro1.synth.127@example.test', '+9231000127') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '12 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 7', 'micro1.synth.128@example.test', '+9231000128') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '53 days', now() - interval '50 days', NULL, now() - interval '44 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 7', 'micro1.synth.129@example.test', '+9231000129') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '94 days', now() - interval '91 days', NULL, now() - interval '85 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 7', 'micro1.synth.130@example.test', '+9231000130') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '135 days', now() - interval '132 days', NULL, now() - interval '126 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 7', 'micro1.synth.131@example.test', '+9231000131') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '176 days', now() - interval '173 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 7', 'micro1.synth.132@example.test', '+9231000132') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '17 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 7', 'micro1.synth.133@example.test', '+9231000133') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '58 days', now() - interval '55 days', NULL, now() - interval '49 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 7', 'micro1.synth.134@example.test', '+9231000134') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '99 days', now() - interval '96 days', NULL, now() - interval '90 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 7', 'micro1.synth.135@example.test', '+9231000135') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '140 days', now() - interval '137 days', NULL, now() - interval '131 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 7', 'micro1.synth.136@example.test', '+9231000136') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '181 days', now() - interval '178 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 7', 'micro1.synth.137@example.test', '+9231000137') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '22 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 7', 'micro1.synth.138@example.test', '+9231000138') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '63 days', now() - interval '60 days', NULL, now() - interval '54 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 7', 'micro1.synth.139@example.test', '+9231000139') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '104 days', now() - interval '101 days', NULL, now() - interval '95 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 8', 'micro1.synth.140@example.test', '+9231000140') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '145 days', now() - interval '142 days', NULL, now() - interval '136 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 8', 'micro1.synth.141@example.test', '+9231000141') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '186 days', now() - interval '183 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 8', 'micro1.synth.142@example.test', '+9231000142') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '27 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 8', 'micro1.synth.143@example.test', '+9231000143') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '68 days', now() - interval '65 days', NULL, now() - interval '59 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 8', 'micro1.synth.144@example.test', '+9231000144') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '109 days', now() - interval '106 days', NULL, now() - interval '100 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 8', 'micro1.synth.145@example.test', '+9231000145') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '150 days', now() - interval '147 days', NULL, now() - interval '141 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 8', 'micro1.synth.146@example.test', '+9231000146') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '191 days', now() - interval '188 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 8', 'micro1.synth.147@example.test', '+9231000147') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '32 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 8', 'micro1.synth.148@example.test', '+9231000148') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '73 days', now() - interval '70 days', NULL, now() - interval '64 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 8', 'micro1.synth.149@example.test', '+9231000149') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '114 days', now() - interval '111 days', NULL, now() - interval '105 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 8', 'micro1.synth.150@example.test', '+9231000150') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '155 days', now() - interval '152 days', NULL, now() - interval '146 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 8', 'micro1.synth.151@example.test', '+9231000151') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '196 days', now() - interval '193 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 8', 'micro1.synth.152@example.test', '+9231000152') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '37 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 8', 'micro1.synth.153@example.test', '+9231000153') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '78 days', now() - interval '75 days', NULL, now() - interval '69 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 8', 'micro1.synth.154@example.test', '+9231000154') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '119 days', now() - interval '116 days', NULL, now() - interval '110 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 8', 'micro1.synth.155@example.test', '+9231000155') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '160 days', now() - interval '157 days', NULL, now() - interval '151 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 8', 'micro1.synth.156@example.test', '+9231000156') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '201 days', now() - interval '198 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 8', 'micro1.synth.157@example.test', '+9231000157') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '42 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 8', 'micro1.synth.158@example.test', '+9231000158') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '83 days', now() - interval '80 days', NULL, now() - interval '74 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 8', 'micro1.synth.159@example.test', '+9231000159') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '124 days', now() - interval '121 days', NULL, now() - interval '115 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 9', 'micro1.synth.160@example.test', '+9231000160') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '165 days', now() - interval '162 days', NULL, now() - interval '156 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 9', 'micro1.synth.161@example.test', '+9231000161') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '6 days', now() - interval '3 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 9', 'micro1.synth.162@example.test', '+9231000162') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '47 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 9', 'micro1.synth.163@example.test', '+9231000163') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '88 days', now() - interval '85 days', NULL, now() - interval '79 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 9', 'micro1.synth.164@example.test', '+9231000164') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '129 days', now() - interval '126 days', NULL, now() - interval '120 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 9', 'micro1.synth.165@example.test', '+9231000165') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '170 days', now() - interval '167 days', NULL, now() - interval '161 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 9', 'micro1.synth.166@example.test', '+9231000166') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '11 days', now() - interval '8 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 9', 'micro1.synth.167@example.test', '+9231000167') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '52 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 9', 'micro1.synth.168@example.test', '+9231000168') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '93 days', now() - interval '90 days', NULL, now() - interval '84 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 9', 'micro1.synth.169@example.test', '+9231000169') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '134 days', now() - interval '131 days', NULL, now() - interval '125 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 9', 'micro1.synth.170@example.test', '+9231000170') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '175 days', now() - interval '172 days', NULL, now() - interval '166 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 9', 'micro1.synth.171@example.test', '+9231000171') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '16 days', now() - interval '13 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 9', 'micro1.synth.172@example.test', '+9231000172') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '57 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 9', 'micro1.synth.173@example.test', '+9231000173') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '98 days', now() - interval '95 days', NULL, now() - interval '89 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 9', 'micro1.synth.174@example.test', '+9231000174') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '139 days', now() - interval '136 days', NULL, now() - interval '130 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 9', 'micro1.synth.175@example.test', '+9231000175') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '180 days', now() - interval '177 days', NULL, now() - interval '171 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 9', 'micro1.synth.176@example.test', '+9231000176') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '21 days', now() - interval '18 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 9', 'micro1.synth.177@example.test', '+9231000177') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '62 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 9', 'micro1.synth.178@example.test', '+9231000178') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '103 days', now() - interval '100 days', NULL, now() - interval '94 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 9', 'micro1.synth.179@example.test', '+9231000179') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '144 days', now() - interval '141 days', NULL, now() - interval '135 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 10', 'micro1.synth.180@example.test', '+9231000180') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '185 days', now() - interval '182 days', NULL, now() - interval '176 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 10', 'micro1.synth.181@example.test', '+9231000181') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '26 days', now() - interval '23 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 10', 'micro1.synth.182@example.test', '+9231000182') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '67 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 10', 'micro1.synth.183@example.test', '+9231000183') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '108 days', now() - interval '105 days', NULL, now() - interval '99 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 10', 'micro1.synth.184@example.test', '+9231000184') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '149 days', now() - interval '146 days', NULL, now() - interval '140 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 10', 'micro1.synth.185@example.test', '+9231000185') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '190 days', now() - interval '187 days', NULL, now() - interval '181 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 10', 'micro1.synth.186@example.test', '+9231000186') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '31 days', now() - interval '28 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 10', 'micro1.synth.187@example.test', '+9231000187') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '72 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 10', 'micro1.synth.188@example.test', '+9231000188') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '113 days', now() - interval '110 days', NULL, now() - interval '104 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 10', 'micro1.synth.189@example.test', '+9231000189') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '154 days', now() - interval '151 days', NULL, now() - interval '145 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 10', 'micro1.synth.190@example.test', '+9231000190') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '195 days', now() - interval '192 days', NULL, now() - interval '186 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 10', 'micro1.synth.191@example.test', '+9231000191') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '36 days', now() - interval '33 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 10', 'micro1.synth.192@example.test', '+9231000192') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '77 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 10', 'micro1.synth.193@example.test', '+9231000193') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '118 days', now() - interval '115 days', NULL, now() - interval '109 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 10', 'micro1.synth.194@example.test', '+9231000194') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '159 days', now() - interval '156 days', NULL, now() - interval '150 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 10', 'micro1.synth.195@example.test', '+9231000195') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '200 days', now() - interval '197 days', NULL, now() - interval '191 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 10', 'micro1.synth.196@example.test', '+9231000196') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '41 days', now() - interval '38 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 10', 'micro1.synth.197@example.test', '+9231000197') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '82 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 10', 'micro1.synth.198@example.test', '+9231000198') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '123 days', now() - interval '120 days', NULL, now() - interval '114 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 10', 'micro1.synth.199@example.test', '+9231000199') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '164 days', now() - interval '161 days', NULL, now() - interval '155 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 11', 'micro1.synth.200@example.test', '+9231000200') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '5 days', now() - interval '2 days', NULL, now() - interval '-4 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 11', 'micro1.synth.201@example.test', '+9231000201') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '46 days', now() - interval '43 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 11', 'micro1.synth.202@example.test', '+9231000202') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '87 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 11', 'micro1.synth.203@example.test', '+9231000203') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '128 days', now() - interval '125 days', NULL, now() - interval '119 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 11', 'micro1.synth.204@example.test', '+9231000204') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '169 days', now() - interval '166 days', NULL, now() - interval '160 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 11', 'micro1.synth.205@example.test', '+9231000205') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '10 days', now() - interval '7 days', NULL, now() - interval '1 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 11', 'micro1.synth.206@example.test', '+9231000206') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '51 days', now() - interval '48 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 11', 'micro1.synth.207@example.test', '+9231000207') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '92 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 11', 'micro1.synth.208@example.test', '+9231000208') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '133 days', now() - interval '130 days', NULL, now() - interval '124 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 11', 'micro1.synth.209@example.test', '+9231000209') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '174 days', now() - interval '171 days', NULL, now() - interval '165 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 11', 'micro1.synth.210@example.test', '+9231000210') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '15 days', now() - interval '12 days', NULL, now() - interval '6 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 11', 'micro1.synth.211@example.test', '+9231000211') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '56 days', now() - interval '53 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 11', 'micro1.synth.212@example.test', '+9231000212') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '97 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 11', 'micro1.synth.213@example.test', '+9231000213') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '138 days', now() - interval '135 days', NULL, now() - interval '129 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 11', 'micro1.synth.214@example.test', '+9231000214') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '179 days', now() - interval '176 days', NULL, now() - interval '170 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 11', 'micro1.synth.215@example.test', '+9231000215') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '20 days', now() - interval '17 days', NULL, now() - interval '11 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 11', 'micro1.synth.216@example.test', '+9231000216') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '61 days', now() - interval '58 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 11', 'micro1.synth.217@example.test', '+9231000217') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '102 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 11', 'micro1.synth.218@example.test', '+9231000218') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '143 days', now() - interval '140 days', NULL, now() - interval '134 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 11', 'micro1.synth.219@example.test', '+9231000219') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '184 days', now() - interval '181 days', NULL, now() - interval '175 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 12', 'micro1.synth.220@example.test', '+9231000220') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '25 days', now() - interval '22 days', NULL, now() - interval '16 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 12', 'micro1.synth.221@example.test', '+9231000221') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '66 days', now() - interval '63 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 12', 'micro1.synth.222@example.test', '+9231000222') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '107 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 12', 'micro1.synth.223@example.test', '+9231000223') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '148 days', now() - interval '145 days', NULL, now() - interval '139 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 12', 'micro1.synth.224@example.test', '+9231000224') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '189 days', now() - interval '186 days', NULL, now() - interval '180 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 12', 'micro1.synth.225@example.test', '+9231000225') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '30 days', now() - interval '27 days', NULL, now() - interval '21 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 12', 'micro1.synth.226@example.test', '+9231000226') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '71 days', now() - interval '68 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 12', 'micro1.synth.227@example.test', '+9231000227') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '112 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 12', 'micro1.synth.228@example.test', '+9231000228') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '153 days', now() - interval '150 days', NULL, now() - interval '144 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 12', 'micro1.synth.229@example.test', '+9231000229') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '194 days', now() - interval '191 days', NULL, now() - interval '185 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 12', 'micro1.synth.230@example.test', '+9231000230') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '35 days', now() - interval '32 days', NULL, now() - interval '26 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 12', 'micro1.synth.231@example.test', '+9231000231') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '76 days', now() - interval '73 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 12', 'micro1.synth.232@example.test', '+9231000232') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '117 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 12', 'micro1.synth.233@example.test', '+9231000233') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '158 days', now() - interval '155 days', NULL, now() - interval '149 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 12', 'micro1.synth.234@example.test', '+9231000234') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '199 days', now() - interval '196 days', NULL, now() - interval '190 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 12', 'micro1.synth.235@example.test', '+9231000235') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '40 days', now() - interval '37 days', NULL, now() - interval '31 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 12', 'micro1.synth.236@example.test', '+9231000236') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '81 days', now() - interval '78 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 12', 'micro1.synth.237@example.test', '+9231000237') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '122 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 12', 'micro1.synth.238@example.test', '+9231000238') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '163 days', now() - interval '160 days', NULL, now() - interval '154 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 12', 'micro1.synth.239@example.test', '+9231000239') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '204 days', now() - interval '201 days', NULL, now() - interval '195 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 13', 'micro1.synth.240@example.test', '+9231000240') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '45 days', now() - interval '42 days', NULL, now() - interval '36 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 13', 'micro1.synth.241@example.test', '+9231000241') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '86 days', now() - interval '83 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 13', 'micro1.synth.242@example.test', '+9231000242') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '127 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 13', 'micro1.synth.243@example.test', '+9231000243') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '168 days', now() - interval '165 days', NULL, now() - interval '159 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 13', 'micro1.synth.244@example.test', '+9231000244') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '9 days', now() - interval '6 days', NULL, now() - interval '0 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 13', 'micro1.synth.245@example.test', '+9231000245') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '50 days', now() - interval '47 days', NULL, now() - interval '41 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 13', 'micro1.synth.246@example.test', '+9231000246') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '91 days', now() - interval '88 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 13', 'micro1.synth.247@example.test', '+9231000247') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '132 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 13', 'micro1.synth.248@example.test', '+9231000248') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '173 days', now() - interval '170 days', NULL, now() - interval '164 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 13', 'micro1.synth.249@example.test', '+9231000249') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '14 days', now() - interval '11 days', NULL, now() - interval '5 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 13', 'micro1.synth.250@example.test', '+9231000250') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '55 days', now() - interval '52 days', NULL, now() - interval '46 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 13', 'micro1.synth.251@example.test', '+9231000251') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '96 days', now() - interval '93 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 13', 'micro1.synth.252@example.test', '+9231000252') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '137 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 13', 'micro1.synth.253@example.test', '+9231000253') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '178 days', now() - interval '175 days', NULL, now() - interval '169 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 13', 'micro1.synth.254@example.test', '+9231000254') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '19 days', now() - interval '16 days', NULL, now() - interval '10 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 13', 'micro1.synth.255@example.test', '+9231000255') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '60 days', now() - interval '57 days', NULL, now() - interval '51 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Layla', 'Ibrahim 13', 'micro1.synth.256@example.test', '+9231000256') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '101 days', now() - interval '98 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Marco', 'Rossi 13', 'micro1.synth.257@example.test', '+9231000257') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '142 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ananya', 'Iyer 13', 'micro1.synth.258@example.test', '+9231000258') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '183 days', now() - interval '180 days', NULL, now() - interval '174 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Diego', 'Lopez 13', 'micro1.synth.259@example.test', '+9231000259') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '24 days', now() - interval '21 days', NULL, now() - interval '15 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Wei', 'Chen 14', 'micro1.synth.260@example.test', '+9231000260') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '65 days', now() - interval '62 days', NULL, now() - interval '56 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Yuki', 'Tanaka 14', 'micro1.synth.261@example.test', '+9231000261') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '106 days', now() - interval '103 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Fatima', 'Al-Sayed 14', 'micro1.synth.262@example.test', '+9231000262') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '147 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Omar', 'Hassan 14', 'micro1.synth.263@example.test', '+9231000263') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '188 days', now() - interval '185 days', NULL, now() - interval '179 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Grace', 'Okafor 14', 'micro1.synth.264@example.test', '+9231000264') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '29 days', now() - interval '26 days', NULL, now() - interval '20 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma 14', 'micro1.synth.265@example.test', '+9231000265') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '70 days', now() - interval '67 days', NULL, now() - interval '61 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Carlos', 'Rodriguez 14', 'micro1.synth.266@example.test', '+9231000266') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '111 days', now() - interval '108 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Lukas', 'Muller 14', 'micro1.synth.267@example.test', '+9231000267') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '152 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sipho', 'Khumalo 14', 'micro1.synth.268@example.test', '+9231000268') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '193 days', now() - interval '190 days', NULL, now() - interval '184 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Emily', 'Davis 14', 'micro1.synth.269@example.test', '+9231000269') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '34 days', now() - interval '31 days', NULL, now() - interval '25 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Ahmed', 'Al-Rashid 14', 'micro1.synth.270@example.test', '+9231000270') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '75 days', now() - interval '72 days', NULL, now() - interval '66 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Mei', 'Lin 14', 'micro1.synth.271@example.test', '+9231000271') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'applied', now() - interval '116 days', now() - interval '113 days', NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Jamal', 'Osei 14', 'micro1.synth.272@example.test', '+9231000272') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'referred', now() - interval '157 days', NULL, NULL, NULL, 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Sofia', 'Fernandez 14', 'micro1.synth.273@example.test', '+9231000273') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'Full Stack Developer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '198 days', now() - interval '195 days', NULL, now() - interval '189 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Arjun', 'Reddy 14', 'micro1.synth.274@example.test', '+9231000274') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 1';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'ML Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '39 days', now() - interval '36 days', NULL, now() - interval '30 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

  INSERT INTO public.candidates (first_name, last_name, email, phone) VALUES ('Hana', 'Kim 14', 'micro1.synth.275@example.test', '+9231000275') RETURNING id INTO v_cand_id;
  SELECT id INTO v_acct_id FROM public.accounts WHERE platform_id = micro1_id AND name = 'Micro1 Account 2';
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = micro1_id AND title = 'QA Engineer';
  INSERT INTO public.referrals (candidate_id, platform_id, account_id, job_id, status, referral_date, applied_at, hired_at, not_hired_at, hours_completed)
  VALUES (v_cand_id, micro1_id, v_acct_id, v_job_id, 'not_hired', now() - interval '80 days', now() - interval '77 days', NULL, now() - interval '71 days', 0)
  ON CONFLICT (candidate_id, platform_id, job_id) DO NOTHING;

END $$;

-- Realistic paid/pending split: most bonuses are still owed ("remaining"),
-- but mark a portion as already paid, matching real-world state.
WITH to_pay AS (
  SELECT id FROM public.bonus_records WHERE status = 'remaining'
  ORDER BY random() LIMIT (SELECT ceil(count(*) * 0.3) FROM public.bonus_records WHERE status = 'remaining')
)
UPDATE public.bonus_records
SET status = 'paid', paid_at = earned_at + ((random() * 20 + 3) || ' days')::interval, exchange_rate_used = 265
WHERE id IN (SELECT id FROM to_pay);
