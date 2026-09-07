-- Supports self-service candidate intake (Google Form -> webhook) alongside
-- the existing referral-first flow. A form submission just creates/updates a
-- bare candidate row (no referral yet) - you assign them to a platform/
-- account/job later via the Referrals page when appropriate.

ALTER TABLE public.candidates
  ADD COLUMN IF NOT EXISTS intro TEXT,
  ADD COLUMN IF NOT EXISTS primary_skills TEXT,
  ADD COLUMN IF NOT EXISTS secondary_skills TEXT,
  ADD COLUMN IF NOT EXISTS source TEXT NOT NULL DEFAULT 'manual' CHECK (source IN ('manual', 'google_form'));

CREATE INDEX IF NOT EXISTS idx_candidates_source ON public.candidates(source);
