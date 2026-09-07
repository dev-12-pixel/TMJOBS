-- Clean-slate rebuild: the old schema (clients/job_profiles/payments/etc, and
-- users/candidates/referrals in their old shape) is being replaced entirely.
-- No production data exists to preserve (confirmed before this rebuild).
-- CASCADE drops each table's own policies, indexes, and FKs along with it.

DROP TRIGGER IF EXISTS trigger_set_user_role ON auth.users;

DROP TABLE IF EXISTS public.payments CASCADE;
DROP TABLE IF EXISTS public.tracking_events CASCADE;
DROP TABLE IF EXISTS public.referrals CASCADE;
DROP TABLE IF EXISTS public.candidates CASCADE;
DROP TABLE IF EXISTS public.job_profiles CASCADE;
DROP TABLE IF EXISTS public.clients CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;

DROP FUNCTION IF EXISTS public.calculate_earnings(UUID);
DROP FUNCTION IF EXISTS public.update_referral_status();
DROP FUNCTION IF EXISTS public.handle_new_user();
