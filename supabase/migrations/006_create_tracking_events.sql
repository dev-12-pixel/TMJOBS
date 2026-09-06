CREATE TABLE IF NOT EXISTS tracking_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referral_id UUID REFERENCES public.referrals(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL CHECK (event_type IN ('applied', 'signed_up', 'hired', 'not_hired', 'emailed')),
  event_date TIMESTAMPTZ DEFAULT now(),
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.tracking_events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view tracking events for their referrals" ON public.tracking_events
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.referrals r
      WHERE r.id = tracking_events.referral_id AND r.referrer_id = auth.uid()
    )
  );

CREATE POLICY "Authenticated users can insert tracking events" ON public.tracking_events
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.referrals r
      WHERE r.id = tracking_events.referral_id AND r.referrer_id = auth.uid()
    )
  );

CREATE INDEX IF NOT EXISTS idx_tracking_events_referral_id ON public.tracking_events(referral_id);
CREATE INDEX IF NOT EXISTS idx_tracking_events_event_type ON public.tracking_events(event_type);
CREATE INDEX IF NOT EXISTS idx_tracking_events_event_date ON public.tracking_events(event_date);
