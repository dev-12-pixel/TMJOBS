import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const { prompt, userId } = await req.json();
    const supabaseUrl = Deno.env.get('SUPABASE_URL') || '';
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_KEY') || '';
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    const { data: { user } } = await supabase.auth.getUser(req.headers.get('Authorization')?.replace('Bearer ', '') || '');

    if (!user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const [referralsRes, paymentsRes, profilesRes, candidatesRes] = await Promise.all([
      supabase.from('referrals').select('*'),
      supabase.from('payments').select('*'),
      supabase.from('job_profiles').select('*'),
      supabase.from('candidates').select('*'),
    ]);

    const referrals = referralsRes.data || [];
    const payments = paymentsRes.data || [];
    const profiles = profilesRes.data || [];
    const candidates = candidatesRes.data || [];

    const totalHired = referrals.filter(r => r.status === 'hired').length;
    const totalReferrals = referrals.length;
    const totalReceivable = payments.reduce((sum: number, p: any) => sum + p.amount, 0);
    const hiredRate = totalReferrals > 0 ? ((totalHired / totalReferrals) * 100).toFixed(1) : '0';

    const response = `Based on your TMJOBS data:\n\n` +
      `Total Referrals: ${totalReferrals}\n` +
      `Total Hired: ${totalHired}\n` +
      `Hiring Rate: ${hiredRate}%\n` +
      `Total Receivable: $${totalReceivable.toFixed(2)}\n\n` +
      `Breakdown by Profile:\n` +
      profiles.map(p => {
        const pHired = referrals.filter(r => r.job_profile_id === p.id && r.status === 'hired').length;
        return `  ${p.title}: ${pHired} hired, $${pHired * p.referral_bonus_amount.toFixed(2)} receivable`;
      }).join('\n');

    return new Response(JSON.stringify({ response }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error instanceof Error ? error.message : 'Unknown error' }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
