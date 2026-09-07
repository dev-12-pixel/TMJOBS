import { createClient, SupabaseClient } from '@supabase/supabase-js';

// Shared by both transports (stdio, for Claude Desktop/Code; HTTP, for
// ChatGPT via a tunnel) so there's exactly one implementation of each tool.
// All tools read from vw_referral_dashboard - the same view the web dashboard
// queries - so numbers reported back always match what's on screen. Read-only
// by design: nothing here can create, update, or delete anything.

export function createMcpSupabaseClient(): SupabaseClient {
  const supabaseUrl = process.env.MCP_SUPABASE_URL || '';
  const supabaseServiceKey = process.env.MCP_SUPABASE_SERVICE_KEY || '';
  return createClient(supabaseUrl, supabaseServiceKey);
}

export const TOOL_DEFINITIONS = [
  { name: 'get_dashboard_summary', description: 'Overall referral/hiring/bonus summary across all platforms', inputSchema: { type: 'object', properties: {} } },
  { name: 'get_platform_stats', description: 'Referral/hiring/receivable stats for one platform', inputSchema: { type: 'object', properties: { platform_id: { type: 'string' } }, required: ['platform_id'] } },
  { name: 'get_account_stats', description: 'Referral/hiring stats and hire list for one referral account', inputSchema: { type: 'object', properties: { account_id: { type: 'string' } }, required: ['account_id'] } },
  { name: 'get_candidate', description: 'Full referral/bonus history for one candidate', inputSchema: { type: 'object', properties: { candidate_id: { type: 'string' } }, required: ['candidate_id'] } },
  { name: 'search_candidates', description: 'Search candidates by name, email, or phone', inputSchema: { type: 'object', properties: { query: { type: 'string' } }, required: ['query'] } },
  { name: 'get_receivables', description: 'Total outstanding bonus money owed, broken down by candidate', inputSchema: { type: 'object', properties: {} } },
  { name: 'get_receivables_by_account', description: 'Outstanding bonus money owed, grouped by referral account', inputSchema: { type: 'object', properties: {} } },
] as const;

async function getDashboardSummary(supabase: SupabaseClient) {
  const { data: rows, error } = await supabase.from('vw_referral_dashboard').select('*');
  if (error) return { error: error.message };
  const all = rows || [];
  const hired = all.filter((r) => r.status === 'hired');
  const notHired = all.filter((r) => r.status === 'not_hired');
  const applied = all.filter((r) => r.applied_at !== null);
  return {
    referrals: all.length,
    applied: applied.length,
    hired: hired.length,
    not_hired: notHired.length,
    referral_to_hire_rate: all.length ? Number((hired.length / all.length * 100).toFixed(1)) : 0,
    receivable: all.filter((r) => r.bonus_status === 'remaining').reduce((s, r) => s + Number(r.bonus_amount || 0), 0),
    paid: all.filter((r) => r.bonus_status === 'paid').reduce((s, r) => s + Number(r.bonus_amount || 0), 0),
  };
}

async function getPlatformStats(supabase: SupabaseClient, platformId: string) {
  const { data: platform } = await supabase.from('platforms').select('*').eq('id', platformId).maybeSingle();
  const { data: rows, error } = await supabase.from('vw_referral_dashboard').select('*').eq('platform_id', platformId);
  if (error) return { error: error.message };
  const all = rows || [];
  const hired = all.filter((r) => r.status === 'hired');
  return {
    platform: platform?.name || platformId,
    referrals: all.length,
    hired: hired.length,
    not_hired: all.filter((r) => r.status === 'not_hired').length,
    hire_rate: all.length ? Number((hired.length / all.length * 100).toFixed(1)) : 0,
    receivable: all.filter((r) => r.bonus_status === 'remaining').reduce((s, r) => s + Number(r.bonus_amount || 0), 0),
  };
}

async function getAccountStats(supabase: SupabaseClient, accountId: string) {
  const { data: account } = await supabase.from('accounts').select('*').eq('id', accountId).maybeSingle();
  const { data: rows, error } = await supabase.from('vw_referral_dashboard').select('*').eq('account_id', accountId);
  if (error) return { error: error.message };
  const all = rows || [];
  const hired = all.filter((r) => r.status === 'hired');
  return {
    account: account?.name || accountId,
    referrals: all.length,
    hired: hired.length,
    hire_rate: all.length ? Number((hired.length / all.length * 100).toFixed(1)) : 0,
    hires: hired.map((r) => ({ candidate: `${r.first_name} ${r.last_name}`, job: r.job_title, hired_at: r.hired_at })),
  };
}

async function getCandidate(supabase: SupabaseClient, candidateId: string) {
  const { data: candidate } = await supabase.from('candidates').select('*').eq('id', candidateId).maybeSingle();
  if (!candidate) return { error: 'Candidate not found' };
  const { data: referrals } = await supabase.from('vw_referral_dashboard').select('*').eq('candidate_id', candidateId);
  return {
    candidate: { name: `${candidate.first_name} ${candidate.last_name}`, email: candidate.email, phone: candidate.phone },
    referrals: (referrals || []).map((r) => ({
      platform: r.platform_name, account: r.account_name, job: r.job_title,
      status: r.status, bonus_amount: r.bonus_amount, bonus_status: r.bonus_status,
    })),
  };
}

async function searchCandidates(supabase: SupabaseClient, query: string) {
  const { data, error } = await supabase
    .from('candidates')
    .select('*')
    .or(`first_name.ilike.%${query}%,last_name.ilike.%${query}%,email.ilike.%${query}%,phone.ilike.%${query}%`)
    .limit(20);
  if (error) return { error: error.message };
  return { candidates: (data || []).map((c) => ({ id: c.id, name: `${c.first_name} ${c.last_name}`, email: c.email, phone: c.phone })) };
}

async function getReceivables(supabase: SupabaseClient) {
  const { data, error } = await supabase.from('vw_referral_dashboard').select('*').eq('bonus_status', 'remaining');
  if (error) return { error: error.message };
  const rows = data || [];
  return {
    total_receivable: rows.reduce((s, r) => s + Number(r.bonus_amount || 0), 0),
    count: rows.length,
    by_candidate: rows.map((r) => ({ candidate: `${r.first_name} ${r.last_name}`, platform: r.platform_name, amount: r.bonus_amount })),
  };
}

async function getReceivablesByAccount(supabase: SupabaseClient) {
  const { data, error } = await supabase.from('vw_referral_dashboard').select('*').eq('bonus_status', 'remaining');
  if (error) return { error: error.message };
  const byAccount: Record<string, number> = {};
  (data || []).forEach((r) => {
    byAccount[r.account_name] = (byAccount[r.account_name] || 0) + Number(r.bonus_amount || 0);
  });
  return { receivable_by_account: byAccount };
}

export async function callTool(supabase: SupabaseClient, name: string, args: Record<string, string>): Promise<unknown> {
  switch (name) {
    case 'get_dashboard_summary': return getDashboardSummary(supabase);
    case 'get_platform_stats': return getPlatformStats(supabase, args.platform_id);
    case 'get_account_stats': return getAccountStats(supabase, args.account_id);
    case 'get_candidate': return getCandidate(supabase, args.candidate_id);
    case 'search_candidates': return searchCandidates(supabase, args.query);
    case 'get_receivables': return getReceivables(supabase);
    case 'get_receivables_by_account': return getReceivablesByAccount(supabase);
    default: return { error: `Unknown tool: ${name}` };
  }
}
