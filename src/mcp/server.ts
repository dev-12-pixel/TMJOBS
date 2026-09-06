import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.MCP_SUPABASE_URL || '';
const supabaseServiceKey = process.env.MCP_SUPABASE_SERVICE_KEY || '';
const supabase = createClient(supabaseUrl, supabaseServiceKey);

const server = new Server(
  {
    name: 'tmjobs-mcp',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

async function getDashboardSummary() {
  const { data: { users } } = await supabase.from('users').select('*');
  const { data: referrals } = await supabase.from('referrals').select('*');
  const { data: payments } = await supabase.from('payments').select('*');
  const { data: jobProfiles } = await supabase.from('job_profiles').select('*');
  const { data: clients } = await supabase.from('clients').select('*');

  const totalReferrals = referrals?.length || 0;
  const totalHired = referrals?.filter(r => r.status === 'hired').length || 0;
  const totalReceivable = payments?.reduce((sum, p) => sum + p.amount, 0) || 0;

  return {
    totalUsers: users?.length || 0,
    totalReferrals,
    totalHired,
    totalHiredRate: totalReferrals > 0 ? ((totalHired / totalReferrals) * 100).toFixed(1) : '0',
    totalReceivable,
    totalClients: clients?.length || 0,
    totalJobProfiles: jobProfiles?.length || 0,
  };
}

async function getClientMetrics(clientId: string) {
  const { data: clients } = await supabase.from('clients').select('*').eq('id', clientId).single();
  const { data: jobProfiles } = await supabase.from('job_profiles').select('*').eq('client_id', clientId);
  const { data: candidates } = await supabase.from('candidates').select('*').in('job_profile_id', jobProfiles?.map(p => p.id) || []);
  const { data: referrals } = await supabase.from('referrals').select('*').in('candidate_id', candidates?.map(c => c.id) || []);
  const { data: payments } = await supabase.from('payments').select('*').in('candidate_id', candidates?.map(c => c.id) || []);

  const totalProfiles = jobProfiles?.length || 0;
  const totalReferrals = referrals?.length || 0;
  const totalHired = referrals?.filter(r => r.status === 'hired').length || 0;
  const totalNotHired = referrals?.filter(r => r.status === 'not_hired').length || 0;
  const totalSignedUp = referrals?.filter(r => r.status === 'signed_up').length || 0;
  const totalEmailed = totalReferrals;
  const totalReceivable = payments?.reduce((sum, p) => sum + p.amount, 0) || 0;

  const receivableByProfile: Record<string, number> = {};
  const receivableByHire: Record<string, number> = {};

  jobProfiles?.forEach(p => {
    const pHired = referrals?.filter(r => r.job_profile_id === p.id && r.status === 'hired') || [];
    receivableByProfile[p.title] = pHired.length * p.referral_bonus_amount;
    pHired.forEach(h => {
      const c = candidates?.find(cand => cand.id === h.candidate_id);
      receivableByHire[c?.first_name + ' ' + c?.last_name || h.candidate_id] = p.referral_bonus_amount;
    });
  });

  return {
    clientName: clients?.name || clientId,
    totalProfiles,
    totalReferrals,
    totalSignedUp,
    totalHired,
    totalNotHired,
    totalEmailed,
    appliedToHiredRatio: totalReferrals > 0 ? ((totalHired / totalReferrals) * 100).toFixed(1) : '0',
    totalReceivable,
    receivableByProfile,
    receivableByHire,
  };
}

async function getCandidateStatus(candidateId: string) {
  const { data: candidate } = await supabase.from('candidates').select('*').eq('id', candidateId).single();
  const { data: referrals } = await supabase.from('referrals').select('*').eq('candidate_id', candidateId);
  const { data: payments } = await supabase.from('payments').select('*').eq('candidate_id', candidateId);

  if (!candidate) return { error: 'Candidate not found' };

  return {
    candidate: {
      name: `${candidate.first_name} ${candidate.last_name}`,
      email: candidate.email,
      profile: candidate.job_profile_id,
    },
    referralStatus: referrals?.[0]?.status || 'not found',
    payments: payments?.map(p => ({
      amount: p.amount,
      status: p.status,
    })) || [],
  };
}

async function addCandidate(data: any) {
  const { data, error } = await supabase.from('candidates').insert({
    job_profile_id: data.job_profile_id,
    first_name: data.first_name,
    last_name: data.last_name,
    email: data.email,
    phone: data.phone,
    source: data.source,
    created_by: data.userId,
  }).select().single();

  if (error) return { error: error.message };
  return { candidate: data };
}

async function updateReferralStatus(data: any) {
  const { data, error } = await supabase
    .from('referrals')
    .update({ status: data.status })
    .eq('id', data.referralId)
    .select()
    .single();

  if (error) return { error: error.message };
  return { referral: data };
}

async function getEarnings(data: any) {
  const query = supabase.from('payments').select('*');
  if (data.clientId) query.eq('client_id', data.clientId);
  const { data: payments, error } = await query;
  if (error) return { error: error.message };

  return {
    totalEarnings: payments?.reduce((sum, p) => sum + p.amount, 0) || 0,
    totalPaid: payments?.filter(p => p.status === 'paid').reduce((sum, p) => sum + p.amount, 0) || 0,
    totalPending: payments?.filter(p => p.status === 'pending').reduce((sum, p) => sum + p.amount, 0) || 0,
    breakdown: payments?.map(p => ({
      candidate: p.candidate_id,
      amount: p.amount,
      status: p.status,
      date: p.created_at,
    })) || [],
  };
}

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: 'get_dashboard_summary',
        description: 'Get overall dashboard metrics for all clients',
        inputSchema: {
          type: 'object',
          properties: {
            date_range: { type: 'string', description: 'Optional date range filter' },
          },
        },
      },
      {
        name: 'get_client_metrics',
        description: 'Get detailed metrics for a specific client',
        inputSchema: {
          type: 'object',
          properties: {
            client_id: { type: 'string', description: 'The client ID' },
          },
          required: ['client_id'],
        },
      },
      {
        name: 'get_candidate_status',
        description: 'Get tracking status for a specific candidate',
        inputSchema: {
          type: 'object',
          properties: {
            candidate_id: { type: 'string', description: 'The candidate ID' },
          },
          required: ['candidate_id'],
        },
      },
      {
        name: 'get_earnings',
        description: 'Get referral earnings breakdown',
        inputSchema: {
          type: 'object',
          properties: {
            period: { type: 'string', description: 'Optional period filter' },
            client_id: { type: 'string', description: 'Optional client filter' },
          },
        },
      },
      {
        name: 'add_candidate',
        description: 'Add a new candidate to the system',
        inputSchema: {
          type: 'object',
          properties: {
            client_id: { type: 'string' },
            job_profile_id: { type: 'string' },
            first_name: { type: 'string' },
            last_name: { type: 'string' },
            email: { type: 'string' },
            phone: { type: 'string' },
            source: { type: 'string' },
            userId: { type: 'string' },
          },
          required: ['client_id', 'job_profile_id', 'first_name', 'last_name', 'email', 'userId'],
        },
      },
      {
        name: 'update_referral_status',
        description: 'Update referral status',
        inputSchema: {
          type: 'object',
          properties: {
            referralId: { type: 'string' },
            status: { type: 'string', enum: ['applied', 'signed_up', 'hired', 'not_hired'] },
          },
          required: ['referralId', 'status'],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    switch (name) {
      case 'get_dashboard_summary':
        return { content: [{ type: 'text', text: JSON.stringify(await getDashboardSummary(), null, 2) }] };
      case 'get_client_metrics':
        return { content: [{ type: 'text', text: JSON.stringify(await getClientMetrics(args.client_id), null, 2) }] };
      case 'get_candidate_status':
        return { content: [{ type: 'text', text: JSON.stringify(await getCandidateStatus(args.candidate_id), null, 2) }] };
      case 'get_earnings':
        return { content: [{ type: 'text', text: JSON.stringify(await getEarnings(args), null, 2) }] };
      case 'add_candidate':
        return { content: [{ type: 'text', text: JSON.stringify(await addCandidate(args), null, 2) }] };
      case 'update_referral_status':
        return { content: [{ type: 'text', text: JSON.stringify(await updateReferralStatus(args), null, 2) }] };
      default:
        return { content: [{ type: 'text', text: `Unknown tool: ${name}` }] };
    }
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
