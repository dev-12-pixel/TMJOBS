import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.MCP_SUPABASE_URL || '';
const supabaseServiceKey = process.env.MCP_SUPABASE_SERVICE_KEY || '';
const supabase = createClient(supabaseUrl, supabaseServiceKey);

const server = new Server(
  { name: 'tmjobs-mcp', version: '2.0.0' },
  { capabilities: { tools: {} } }
);

// All tools read from vw_referral_dashboard - the same view the web dashboard
// queries - so numbers reported to Claude always match what's on screen.
// Read-only by design: no tool here can create, update, or delete anything.

async function getDashboardSummary() {
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

async function getPlatformStats(platformId: string) {
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

async function getAccountStats(accountId: string) {
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

async function getCandidate(candidateId: string) {
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

async function searchCandidates(query: string) {
  const { data, error } = await supabase
    .from('candidates')
    .select('*')
    .or(`first_name.ilike.%${query}%,last_name.ilike.%${query}%,email.ilike.%${query}%,phone.ilike.%${query}%`)
    .limit(20);
  if (error) return { error: error.message };
  return { candidates: (data || []).map((c) => ({ id: c.id, name: `${c.first_name} ${c.last_name}`, email: c.email, phone: c.phone })) };
}

async function getReceivables() {
  const { data, error } = await supabase.from('vw_referral_dashboard').select('*').eq('bonus_status', 'remaining');
  if (error) return { error: error.message };
  const rows = data || [];
  return {
    total_receivable: rows.reduce((s, r) => s + Number(r.bonus_amount || 0), 0),
    count: rows.length,
    by_candidate: rows.map((r) => ({ candidate: `${r.first_name} ${r.last_name}`, platform: r.platform_name, amount: r.bonus_amount })),
  };
}

async function getReceivablesByAccount() {
  const { data, error } = await supabase.from('vw_referral_dashboard').select('*').eq('bonus_status', 'remaining');
  if (error) return { error: error.message };
  const byAccount: Record<string, number> = {};
  (data || []).forEach((r) => {
    byAccount[r.account_name] = (byAccount[r.account_name] || 0) + Number(r.bonus_amount || 0);
  });
  return { receivable_by_account: byAccount };
}

const TOOLS = [
  { name: 'get_dashboard_summary', description: 'Overall referral/hiring/bonus summary across all platforms', inputSchema: { type: 'object', properties: {} } },
  { name: 'get_platform_stats', description: 'Referral/hiring/receivable stats for one platform', inputSchema: { type: 'object', properties: { platform_id: { type: 'string' } }, required: ['platform_id'] } },
  { name: 'get_account_stats', description: 'Referral/hiring stats and hire list for one referral account', inputSchema: { type: 'object', properties: { account_id: { type: 'string' } }, required: ['account_id'] } },
  { name: 'get_candidate', description: 'Full referral/bonus history for one candidate', inputSchema: { type: 'object', properties: { candidate_id: { type: 'string' } }, required: ['candidate_id'] } },
  { name: 'search_candidates', description: 'Search candidates by name, email, or phone', inputSchema: { type: 'object', properties: { query: { type: 'string' } }, required: ['query'] } },
  { name: 'get_receivables', description: 'Total outstanding bonus money owed, broken down by candidate', inputSchema: { type: 'object', properties: {} } },
  { name: 'get_receivables_by_account', description: 'Outstanding bonus money owed, grouped by referral account', inputSchema: { type: 'object', properties: {} } },
];

server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools: TOOLS }));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params as { name: string; arguments: Record<string, string> };
  try {
    let result: unknown;
    switch (name) {
      case 'get_dashboard_summary': result = await getDashboardSummary(); break;
      case 'get_platform_stats': result = await getPlatformStats(args.platform_id); break;
      case 'get_account_stats': result = await getAccountStats(args.account_id); break;
      case 'get_candidate': result = await getCandidate(args.candidate_id); break;
      case 'search_candidates': result = await searchCandidates(args.query); break;
      case 'get_receivables': result = await getReceivables(); break;
      case 'get_receivables_by_account': result = await getReceivablesByAccount(); break;
      default: return { content: [{ type: 'text', text: `Unknown tool: ${name}` }] };
    }
    return { content: [{ type: 'text', text: JSON.stringify(result, null, 2) }] };
  } catch (error) {
    return { content: [{ type: 'text', text: `Error: ${error instanceof Error ? error.message : 'Unknown error'}` }] };
  }
});

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error('TMJOBS MCP Server running on stdio');
}

main().catch(console.error);
