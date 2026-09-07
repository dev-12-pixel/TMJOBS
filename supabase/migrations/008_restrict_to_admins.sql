-- Lock the app down to a fixed admin allowlist. Until now every policy only
-- checked auth.role() = 'authenticated', so anyone who signed up (signup is
-- public) got full read/write access to every candidate, referral, and
-- bonus record. This closes that regardless of who else manages to sign up -
-- an unauthorized account can still exist in auth.users, but every query it
-- makes returns nothing / is rejected.

CREATE OR REPLACE FUNCTION public.is_authorized()
RETURNS BOOLEAN AS $$
  SELECT lower(coalesce(auth.jwt() ->> 'email', '')) IN (
    'rhanzala99@gmail.com',
    'afs@gmail.com'
  );
$$ LANGUAGE sql STABLE;

-- users
DROP POLICY IF EXISTS "Authenticated users can view users" ON public.users;
DROP POLICY IF EXISTS "Users can update own profile" ON public.users;
CREATE POLICY "Admins can view users" ON public.users FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can update own profile" ON public.users FOR UPDATE USING (public.is_authorized() AND auth.uid() = id);

-- platforms
DROP POLICY IF EXISTS "Authenticated users can view platforms" ON public.platforms;
DROP POLICY IF EXISTS "Authenticated users can manage platforms" ON public.platforms;
CREATE POLICY "Admins can view platforms" ON public.platforms FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage platforms" ON public.platforms FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- accounts
DROP POLICY IF EXISTS "Authenticated users can view accounts" ON public.accounts;
DROP POLICY IF EXISTS "Authenticated users can manage accounts" ON public.accounts;
CREATE POLICY "Admins can view accounts" ON public.accounts FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage accounts" ON public.accounts FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- jobs
DROP POLICY IF EXISTS "Authenticated users can view jobs" ON public.jobs;
DROP POLICY IF EXISTS "Authenticated users can manage jobs" ON public.jobs;
CREATE POLICY "Admins can view jobs" ON public.jobs FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage jobs" ON public.jobs FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- candidates
DROP POLICY IF EXISTS "Authenticated users can view candidates" ON public.candidates;
DROP POLICY IF EXISTS "Authenticated users can manage candidates" ON public.candidates;
CREATE POLICY "Admins can view candidates" ON public.candidates FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage candidates" ON public.candidates FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- referrals
DROP POLICY IF EXISTS "Authenticated users can view referrals" ON public.referrals;
DROP POLICY IF EXISTS "Authenticated users can manage referrals" ON public.referrals;
CREATE POLICY "Admins can view referrals" ON public.referrals FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage referrals" ON public.referrals FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- referral_status_history
DROP POLICY IF EXISTS "Authenticated users can view referral status history" ON public.referral_status_history;
CREATE POLICY "Admins can view referral status history" ON public.referral_status_history FOR SELECT USING (public.is_authorized());

-- emails
DROP POLICY IF EXISTS "Authenticated users can view emails" ON public.emails;
DROP POLICY IF EXISTS "Authenticated users can manage emails" ON public.emails;
CREATE POLICY "Admins can view emails" ON public.emails FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage emails" ON public.emails FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- bonus_rules
DROP POLICY IF EXISTS "Authenticated users can view bonus rules" ON public.bonus_rules;
DROP POLICY IF EXISTS "Authenticated users can manage bonus rules" ON public.bonus_rules;
CREATE POLICY "Admins can view bonus rules" ON public.bonus_rules FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage bonus rules" ON public.bonus_rules FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- bonus_records
DROP POLICY IF EXISTS "Authenticated users can view bonus records" ON public.bonus_records;
DROP POLICY IF EXISTS "Authenticated users can manage bonus records" ON public.bonus_records;
CREATE POLICY "Admins can view bonus records" ON public.bonus_records FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage bonus records" ON public.bonus_records FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- exchange_rates
DROP POLICY IF EXISTS "Authenticated users can view exchange rates" ON public.exchange_rates;
DROP POLICY IF EXISTS "Authenticated users can manage exchange rates" ON public.exchange_rates;
CREATE POLICY "Admins can view exchange rates" ON public.exchange_rates FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can manage exchange rates" ON public.exchange_rates FOR ALL USING (public.is_authorized()) WITH CHECK (public.is_authorized());

-- audit_logs
DROP POLICY IF EXISTS "Authenticated users can view audit logs" ON public.audit_logs;
DROP POLICY IF EXISTS "Authenticated users can insert audit logs" ON public.audit_logs;
CREATE POLICY "Admins can view audit logs" ON public.audit_logs FOR SELECT USING (public.is_authorized());
CREATE POLICY "Admins can insert audit logs" ON public.audit_logs FOR INSERT WITH CHECK (public.is_authorized());
