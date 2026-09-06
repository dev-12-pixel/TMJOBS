CREATE TABLE IF NOT EXISTS job_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID REFERENCES public.clients(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  location TEXT,
  salary_range TEXT,
  referral_bonus_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'closed', 'draft')),
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.job_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view active job profiles" ON public.job_profiles
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create job profiles" ON public.job_profiles
  FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update own job profiles" ON public.job_profiles
  FOR UPDATE USING (auth.uid() = created_by);

CREATE INDEX IF NOT EXISTS idx_job_profiles_client_id ON public.job_profiles(client_id);
CREATE INDEX IF NOT EXISTS idx_job_profiles_status ON public.job_profiles(status);
