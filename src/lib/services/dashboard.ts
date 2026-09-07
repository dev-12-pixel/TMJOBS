import { supabase } from '@/lib/supabase';
import type { Account, DashboardFilters, DashboardSummary, ReferralDashboardRow } from '@/lib/types';

// Every metric here has one definition, used identically by the main
// dashboard, the per-platform dashboard, and (via the same view) the MCP
// server - so numbers can never quietly drift between them.
//   - Referrals:  total referral rows in scope
//   - Applied:    rows that have reached Applied or beyond (applied_at set)
//   - Hired / Not Hired: rows whose *current* status is that value
//   - Emailed:    distinct candidates in scope with at least one logged email
//   - Bonus buckets: sum of bonus_records.amount in scope, grouped by status

export async function fetchDashboardRows(filters: DashboardFilters): Promise<ReferralDashboardRow[]> {
  let query = supabase.from('vw_referral_dashboard').select('*');
  if (filters.platformId) query = query.eq('platform_id', filters.platformId);
  if (filters.accountId) query = query.eq('account_id', filters.accountId);
  if (filters.dateFrom) query = query.gte('referral_date', filters.dateFrom);
  if (filters.dateTo) query = query.lte('referral_date', filters.dateTo);

  const { data, error } = await query;
  if (error) throw error;
  return data ?? [];
}

export async function fetchAccounts(platformId?: string): Promise<Account[]> {
  let query = supabase.from('accounts').select('*').order('name');
  if (platformId) query = query.eq('platform_id', platformId);
  const { data, error } = await query;
  if (error) throw error;
  return data ?? [];
}

export function summarizeDashboard(rows: ReferralDashboardRow[], accountCount: number): DashboardSummary {
  const referrals = rows.length;
  const applied = rows.filter((r) => r.applied_at !== null).length;
  const hired = rows.filter((r) => r.status === 'hired').length;
  const notHired = rows.filter((r) => r.status === 'not_hired').length;
  const emailed = new Set(rows.filter((r) => r.email_count > 0).map((r) => r.candidate_id)).size;

  const bonusSum = (status: string) =>
    rows.filter((r) => r.bonus_status === status).reduce((sum, r) => sum + Number(r.bonus_amount || 0), 0);

  return {
    accounts: accountCount,
    referrals,
    applied,
    hired,
    notHired,
    emailed,
    referralToHireRate: referrals > 0 ? (hired / referrals) * 100 : 0,
    bonusExpected: bonusSum('expected'),
    bonusRemaining: bonusSum('remaining'),
    bonusPaid: bonusSum('paid'),
    bonusDisputed: bonusSum('disputed'),
  };
}

export function funnelCounts(rows: ReferralDashboardRow[]) {
  return {
    referred: rows.length,
    applied: rows.filter((r) => r.applied_at !== null).length,
    hired: rows.filter((r) => r.status === 'hired').length,
  };
}

export function groupByAccount(rows: ReferralDashboardRow[], accounts: Account[]) {
  return accounts.map((account) => {
    const accountRows = rows.filter((r) => r.account_id === account.id);
    const hired = accountRows.filter((r) => r.status === 'hired').length;
    return {
      account,
      referrals: accountRows.length,
      hired,
      hireRate: accountRows.length > 0 ? (hired / accountRows.length) * 100 : 0,
      bonusTotal: accountRows.reduce((sum, r) => sum + Number(r.bonus_amount || 0), 0),
    };
  });
}
