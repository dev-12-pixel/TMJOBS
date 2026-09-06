CREATE TABLE IF NOT EXISTS referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID REFERENCES public.candidates(id) ON DELETE CASCADE,
  referrer_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
  job_profile_id UUID REFERENCES public.job_profiles(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'applied' CHECK (status IN ('applied', 'signed_up', 'hired', 'not_hired')),
  applied_at TIMESTAMPTZ DEFAULT now(),
  signed_up_at TIMESTAMPTZ,
  hired_at TIMESTAMPTZ,
  not_hired_at TIMESTAMPTZ,
  hired_by TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.update_referral_status()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'signed_up' AND OLD.status != 'signed_up' THEN
    NEW.signed_up_at := COALESCE(NEW.signed_up_at, now());
  ELSIF NEW.status = 'hired' AND OLD.status != 'hired' THEN
    NEW.hired_at := COALESCE(NEW.hired_at, now());
  ELSIF NEW.status = 'not_hired' AND OLD.status != 'not_hired' THEN
    NEW.not_hired_at := COALESCE(NEW.not_hired_at, now());
  END IF;
  NEW.updated_at := now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trigger_update_referral_status ON public.referrals;

CREATE TRIGGER trigger_update_referral_status
  BEFORE UPDATE ON public.referrals
  FOR EACH ROW
  EXECUTE FUNCTION public.update_referral_status();

ALTER TABLE public.referrals ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own referrals" ON public.referrals
  FOR SELECT USING (auth.uid() = referrer_id);

CREATE POLICY "Users can insert own referrals" ON public.referrals
  FOR INSERT WITH CHECK (auth.uid() = referrer_id);

CREATE POLICY "Users can update own referrals" ON public.referrals
  FOR UPDATE USING (auth.uid() = referrer_id);

CREATE INDEX IF NOT EXISTS idx_referrals_candidate_id ON public.referrals(candidate_id);
CREATE INDEX IF NOT EXISTS idx_referrals_referrer_id ON public.referrals(referrer_id);
CREATE INDEX IF NOT EXISTS idx_referrals_job_profile_id ON public.referrals(job_profile_id);
CREATE INDEX IF NOT EXISTS idx_referrals_status ON public.referrals(status);
