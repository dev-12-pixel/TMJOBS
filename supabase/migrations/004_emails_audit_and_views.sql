-- Email log (manual entry for now; schema is ready for future Gmail sync).

CREATE TABLE IF NOT EXISTS public.emails (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES public.candidates(id) ON DELETE CASCADE,
  referral_id UUID REFERENCES public.referrals(id) ON DELETE SET NULL,
  direction TEXT NOT NULL DEFAULT 'sent' CHECK (direction IN ('sent', 'received')),
  email_type TEXT NOT NULL DEFAULT 'other' CHECK (email_type IN ('initial_contact', 'follow_up', 'reminder', 'status_update', 'reply', 'other')),
  subject TEXT,
  sent_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT,
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_emails_candidate_id ON public.emails(candidate_id);
CREATE INDEX IF NOT EXISTS idx_emails_referral_id ON public.emails(referral_id);

ALTER TABLE public.emails ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view emails" ON public.emails
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can manage emails" ON public.emails
  FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

-- Audit trail (table only this pass - no dedicated UI yet).
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.users(id),
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id UUID,
  old_value JSONB,
  new_value JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_entity ON public.audit_logs(entity_type, entity_id);

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view audit logs" ON public.audit_logs
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated users can insert audit logs" ON public.audit_logs
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- One row per referral with every joined field the dashboard, candidate page,
-- and the MCP server all need - so none of them can drift out of sync on what
-- a number means (referral -> hire rate, receivable, etc. all read from here).
CREATE OR REPLACE VIEW public.vw_referral_dashboard AS
SELECT
  r.id AS referral_id,
  r.status,
  r.referral_date,
  r.applied_at,
  r.hired_at,
  r.not_hired_at,
  r.hours_completed,
  c.id AS candidate_id,
  c.first_name,
  c.last_name,
  c.email AS candidate_email,
  p.id AS platform_id,
  p.name AS platform_name,
  p.slug AS platform_slug,
  a.id AS account_id,
  a.name AS account_name,
  j.id AS job_id,
  j.title AS job_title,
  br.id AS bonus_record_id,
  br.amount AS bonus_amount,
  br.currency AS bonus_currency,
  br.status AS bonus_status,
  (SELECT count(*) FROM public.emails e WHERE e.candidate_id = c.id) AS email_count
FROM public.referrals r
JOIN public.candidates c ON c.id = r.candidate_id
JOIN public.platforms p ON p.id = r.platform_id
JOIN public.accounts a ON a.id = r.account_id
JOIN public.jobs j ON j.id = r.job_id
LEFT JOIN public.bonus_records br ON br.referral_id = r.id;
