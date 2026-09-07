-- Reference data: platforms, referral accounts, jobs, bonus rules, exchange rate.
-- Bonus amounts below are placeholders (flagged in-app) until corrected via /bonuses.

INSERT INTO public.platforms (id, name, slug) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Marcor', 'marcor'),
  ('22222222-2222-2222-2222-222222222222', 'Turing', 'turing'),
  ('33333333-3333-3333-3333-333333333333', 'Micro1', 'micro1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.accounts (platform_id, name, identifier) VALUES
  ('22222222-2222-2222-2222-222222222222', 'Turing Account 1', 'turing-1'),
  ('22222222-2222-2222-2222-222222222222', 'Turing Account 2', 'turing-2'),
  ('22222222-2222-2222-2222-222222222222', 'Turing Account 3', 'turing-3'),
  ('33333333-3333-3333-3333-333333333333', 'Micro1 Account 1', 'micro1-1'),
  ('33333333-3333-3333-3333-333333333333', 'Micro1 Account 2', 'micro1-2'),
  ('11111111-1111-1111-1111-111111111111', 'Marcor Account 1', 'marcor-1'),
  ('11111111-1111-1111-1111-111111111111', 'Marcor Account 2', 'marcor-2')
ON CONFLICT DO NOTHING;

INSERT INTO public.jobs (platform_id, title) VALUES
  ('22222222-2222-2222-2222-222222222222', 'AI Engineer'),
  ('22222222-2222-2222-2222-222222222222', 'Backend Engineer'),
  ('22222222-2222-2222-2222-222222222222', 'Frontend Engineer'),
  ('33333333-3333-3333-3333-333333333333', 'Full Stack Developer'),
  ('33333333-3333-3333-3333-333333333333', 'ML Engineer'),
  ('33333333-3333-3333-3333-333333333333', 'QA Engineer'),
  ('11111111-1111-1111-1111-111111111111', 'Data Scientist'),
  ('11111111-1111-1111-1111-111111111111', 'DevOps Engineer')
ON CONFLICT DO NOTHING;

-- Turing & Marcor: hired + 10 hours completed. Micro1: hired (signup is implied
-- by reaching "hired" in the 4-stage funnel), one bonus per candidate ever.
-- effective_from is backdated so it covers historical mock hire dates seeded
-- in 006; a real rule created going forward should just use effective_from=now().
INSERT INTO public.bonus_rules (platform_id, event, hours_requirement, amount, currency, one_time_per_candidate, effective_from) VALUES
  ('22222222-2222-2222-2222-222222222222', 'hired', 10, 100, 'USD', false, '2024-01-01'),
  ('11111111-1111-1111-1111-111111111111', 'hired', 10, 100, 'USD', false, '2024-01-01'),
  ('33333333-3333-3333-3333-333333333333', 'hired', 0, 50, 'USD', true, '2024-01-01')
ON CONFLICT DO NOTHING;

INSERT INTO public.exchange_rates (currency_from, currency_to, rate, effective_date) VALUES
  ('USD', 'PKR', 265, current_date)
ON CONFLICT DO NOTHING;
