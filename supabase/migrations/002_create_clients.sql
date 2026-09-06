CREATE TABLE IF NOT EXISTS clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  logo_url TEXT,
  description TEXT,
  website_url TEXT,
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.clients ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view clients" ON public.clients
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create clients" ON public.clients
  FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update own clients" ON public.clients
  FOR UPDATE USING (auth.uid() = created_by);

INSERT INTO public.clients (id, name, description) VALUES
  ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Major Turing', 'Major Turing - Premium Tech Recruitment'),
  ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'Micro1', 'Micro1 - Specialized Tech Staffing')
ON CONFLICT (id) DO NOTHING;
