CREATE TABLE IF NOT EXISTS candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_profile_id UUID REFERENCES public.job_profiles(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  linkedin_url TEXT,
  resume_url TEXT,
  notes TEXT,
  source TEXT,
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(job_profile_id, email)
);

ALTER TABLE public.candidates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view candidates they created" ON public.candidates
  FOR SELECT USING (auth.uid() = created_by);

CREATE POLICY "Authenticated users can insert candidates" ON public.candidates
  FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update own candidates" ON public.candidates
  FOR UPDATE USING (auth.uid() = created_by);

CREATE INDEX IF NOT EXISTS idx_candidates_job_profile_id ON public.candidates(job_profile_id);
CREATE INDEX IF NOT EXISTS idx_candidates_email ON public.candidates(email);
CREATE INDEX IF NOT EXISTS idx_candidates_created_by ON public.candidates(created_by);
