-- Correct referral_date/applied_at/hired_at for the 66 real Turing referrals
-- imported from "Turing Reffered Candidates.xlsx". Migration 009 derived
-- referral_date as hired_at minus a fixed 10 days, but hired_at itself was
-- a placeholder rather than the sheet's actual per-row date - so every real
-- row was off, and several unrelated rows collapsed onto the same 2
-- calendar days, making the dashboard's "last 3 months" filter look like a
-- wall of duplicate names. This restores each row's true date (read as the
-- referral date, with applied/hired staggered a few days after) and fixes
-- one row where the sheet had a typo'd year (2026 instead of 2025, which
-- would otherwise show a "hired" candidate in the future).
--
-- Matches existing referrals by (candidate name, job title, platform) since
-- that's the only stable key available after the original import; rows with
-- no match are silently skipped rather than erroring, since bulk/synthetic
-- referrals for the same job titles are expected to exist alongside these.

DO $$
DECLARE
  turing_id UUID := '22222222-2222-2222-2222-222222222222';
  v_cand_id UUID;
  v_job_id UUID;
  v_ref_date DATE;
BEGIN

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Small business Owner AI response AI evaluation'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ami') AND lower(last_name) = lower('Ra') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI quality Analyst English'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-26'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Hamza') AND lower(last_name) = lower('Tanveer') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Creative Software specialist ( Open source Tools)'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Muhammad') AND lower(last_name) = lower('Amir') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI quality Analyst English'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Mahnoor') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Text2SQL Developer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ami') AND lower(last_name) = lower('Ra') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM -Trainer Agent Function call'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Haider') AND lower(last_name) = lower('Jamil') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI quality Analyst English'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmed') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Software Engineer With Python and Docker Exerience'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Rida') AND lower(last_name) = lower('Atteq') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Text 2SQL developer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-31'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Khaleeq') AND lower(last_name) = lower('Ur Rehman') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI quality Analyst English'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Software Engineer With Python and Docker Exerience'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Rida') AND lower(last_name) = lower('Ateeq') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI Trainer Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Taiba') AND lower(last_name) = lower('Khalid') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM S3 Annotator (Open Claw Trajectory Specialist)'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmad') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Dockerfile Data validation Engineer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Rida') AND lower(last_name) = lower('Ateeq') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Software Engineer With Python and Docker'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmed') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI Bench Mark engineer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Senior Software Engineer LLM Evaluation'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('(unknown)') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Mathematics Expert PH.d'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Hanzala') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Text2SQL Developer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmed') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM Trainer Software Engineer SWE'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmed') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM Trainer Terminal Bench (Python & Linux system)'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-24'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Mathematics Expert PH.d'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-09'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ume') AND lower(last_name) = lower('Habiba') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Tax Form Expert'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-19'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Tanzeel') AND lower(last_name) = lower('Faisal') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Anotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Video Annotator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-18'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmad') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Video Data Annotator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-31'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('ABDUL') AND lower(last_name) = lower('HAFEEZ') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst (RLHF/ Analyst )'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Hamna') AND lower(last_name) = lower('Noor') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM S2 Annotator (CUA Trajectory Specialist)'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Agentic Coding Annotator Online/ Offline Tasks'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Gaming Specialist'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Haider') AND lower(last_name) = lower('Jamil') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM Trainer Agent Function Call'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Saif') AND lower(last_name) = lower('Ur Rehman') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI safety and Policy Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Science /Anlayst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI trainer Agent Function Call'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Saif') AND lower(last_name) = lower('ur Rehman') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Tax Form Expert'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Tax Form Expert'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Haider') AND lower(last_name) = lower('Jamil') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Tax Form Expert'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('AI quality Analyst English'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ami') AND lower(last_name) = lower('Ra') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-31'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Khaleeq') AND lower(last_name) = lower('Ur Rehman') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Text 2SQL Developer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Haider') AND lower(last_name) = lower('Jamil') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Text 2SQL Developer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-27'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ami') AND lower(last_name) = lower('Ra') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-31'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('ABDUL') AND lower(last_name) = lower('HAFEEZ') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Business Analyst'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Saif') AND lower(last_name) = lower('ur Rehman') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Astronomical Computation Engineer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Astronomical Computation Engineer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM Python Reviwer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('LLM Data quality and tooling Specialist'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-17'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmad') AND lower(last_name) = lower('Farhan') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Senior Software Engineer- LLM Evaluation'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-08-06'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Senior Software Engineer- LLM Evaluation'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-04-07'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Muhammad') AND lower(last_name) = lower('Amir') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Technical Content Writer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-26'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Haider') AND lower(last_name) = lower('Jamil') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotaor Ubuntu Desktop operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Image / Video Annotator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-05-21'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Technical Content Writer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-26'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Maimuna') AND lower(last_name) = lower('Javed') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-22'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Urwa') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-22'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Anas') AND lower(last_name) = lower('Hafeez') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-26'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Hamna') AND lower(last_name) = lower('Noor') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2026-03-02'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahmed') AND lower(last_name) = lower('Tehseen') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Docker file Data validation Engineer'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-26'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Momina') AND lower(last_name) = lower('Saleem') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-29'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Nabel') AND lower(last_name) = lower('Faisal') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-23'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Ahsan') AND lower(last_name) = lower('Sherazi') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-19'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Tanzeel') AND lower(last_name) = lower('Faisal') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;

  v_ref_date := '2025-12-19'::date;
  SELECT id INTO v_cand_id FROM public.candidates WHERE lower(first_name) = lower('Muhammad') AND lower(last_name) = lower('Aslam') LIMIT 1;
  SELECT id INTO v_job_id FROM public.jobs WHERE platform_id = turing_id AND regexp_replace(lower(replace(title, '&amp;', '&')), '\s+', ' ', 'g') = regexp_replace(lower('Data Annotator Ubuntu Desktop Operator'), '\s+', ' ', 'g') LIMIT 1;
  IF v_cand_id IS NOT NULL AND v_job_id IS NOT NULL THEN
    UPDATE public.referrals
    SET referral_date = v_ref_date,
        applied_at = v_ref_date + interval '3 days',
        hired_at = v_ref_date + interval '10 days'
    WHERE candidate_id = v_cand_id AND job_id = v_job_id AND platform_id = turing_id;
  END IF;
END $$;
