'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { Fragment, useEffect, useState, useCallback } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/MetricCard';
import { supabase } from '@/lib/supabase';
import { fetchDashboardRows, fetchDashboardRowsPage, fetchAccounts, summarizeDashboard, funnelCounts } from '@/lib/services/dashboard';
import { formatCurrency, formatPercentage } from '@/lib/utils';
import type { Platform, DashboardSummary, ReferralDashboardRow } from '@/lib/types';
import { Users, Briefcase, CheckCircle, XCircle, Mail, DollarSign, ChevronLeft, ChevronRight, ChevronDown } from 'lucide-react';

const PAGE_SIZE = 10;

// Same candidate can be referred to several jobs through the same account
// (e.g. one person placed on 4 different postings in a week) - group those
// so the table shows one row per candidate+account instead of repeating the
// name several times in a row.
function groupPageRows(rows: ReferralDashboardRow[]) {
  const groups: { key: string; candidate: string; platform: string; account: string; jobs: ReferralDashboardRow[] }[] = [];
  const index = new Map<string, number>();
  for (const r of rows) {
    const key = `${r.candidate_id}:${r.account_id}`;
    if (!index.has(key)) {
      index.set(key, groups.length);
      groups.push({ key, candidate: `${r.first_name} ${r.last_name}`, platform: r.platform_name, account: r.account_name, jobs: [] });
    }
    groups[index.get(key)!].jobs.push(r);
  }
  return groups;
}

export default function DashboardPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [platformId, setPlatformId] = useState('');
  const [dateFrom, setDateFrom] = useState('');
  const [dateTo, setDateTo] = useState('');
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(0);
  const [pageRows, setPageRows] = useState<ReferralDashboardRow[]>([]);
  const [pageTotal, setPageTotal] = useState(0);
  const [pageLoading, setPageLoading] = useState(true);
  const [expanded, setExpanded] = useState<Set<string>>(new Set());

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    supabase.from('platforms').select('*').order('name').then(({ data }) => setPlatforms(data || []));
  }, []);

  const filters = { platformId: platformId || undefined, dateFrom: dateFrom || undefined, dateTo: dateTo || undefined };

  // KPIs/funnel need the full filtered set to be accurate; the table below
  // is paginated server-side (10 rows/page) instead of slicing this array.
  const load = useCallback(async () => {
    setLoading(true);
    try {
      const [dashboardRows, accounts] = await Promise.all([fetchDashboardRows(filters), fetchAccounts(platformId || undefined)]);
      setRows(dashboardRows);
      setSummary(summarizeDashboard(dashboardRows, accounts.length));
    } finally {
      setLoading(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [platformId, dateFrom, dateTo]);

  useEffect(() => {
    if (session) load();
  }, [session, load]);

  useEffect(() => {
    setPage(0);
  }, [platformId, dateFrom, dateTo]);

  useEffect(() => {
    if (!session) return;
    setPageLoading(true);
    fetchDashboardRowsPage(filters, page, PAGE_SIZE)
      .then(({ rows: r, total }) => {
        setPageRows(r);
        setPageTotal(total);
      })
      .finally(() => setPageLoading(false));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [session, platformId, dateFrom, dateTo, page]);

  if (!session) return null;

  const funnel = funnelCounts(rows);
  const funnelStages = [
    { label: 'Referred', count: funnel.referred, color: '#6366f1' },
    { label: 'Applied', count: funnel.applied, color: '#3b82f6' },
    { label: 'Hired', count: funnel.hired, color: '#22c55e' },
  ];

  return (
    <Layout>
      <div className="space-y-6 animate-fade-in">
        <div>
          <h2 className="text-3xl font-bold text-gray-800">Dashboard Overview</h2>
          <p className="text-gray-500 mt-1">Referral, hiring, and bonus metrics across all platforms</p>
        </div>

        <div className="flex flex-wrap items-center gap-4 p-4 bg-white rounded-xl border border-gray-200">
          <label className="text-sm text-gray-600">Platform</label>
          <select value={platformId} onChange={(e) => setPlatformId(e.target.value)} className="px-3 py-2 border border-gray-300 rounded-lg text-sm">
            <option value="">All Platforms</option>
            {platforms.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
          </select>
          <label className="text-sm text-gray-600">Referral Date From</label>
          <input type="date" value={dateFrom} onChange={(e) => setDateFrom(e.target.value)} className="px-3 py-2 border border-gray-300 rounded-lg text-sm" />
          <label className="text-sm text-gray-600">To</label>
          <input type="date" value={dateTo} onChange={(e) => setDateTo(e.target.value)} className="px-3 py-2 border border-gray-300 rounded-lg text-sm" />
          {(platformId || dateFrom || dateTo) && (
            <button onClick={() => { setPlatformId(''); setDateFrom(''); setDateTo(''); }} className="text-sm text-primary-600 font-medium">
              Clear filters
            </button>
          )}
        </div>

        {loading ? (
          <div className="animate-pulse grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {Array.from({ length: 6 }).map((_, i) => <div key={i} className="h-28 bg-gray-200 rounded-xl" />)}
          </div>
        ) : (
          <>
            <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
              <MetricCard icon={<Briefcase className="w-6 h-6 text-primary-600" />} label="Accounts" value={summary?.accounts ?? 0} />
              <MetricCard icon={<Users className="w-6 h-6 text-blue-600" />} label="Referrals" value={summary?.referrals ?? 0} />
              <MetricCard icon={<Users className="w-6 h-6 text-sky-600" />} label="Applied" value={summary?.applied ?? 0} />
              <MetricCard icon={<CheckCircle className="w-6 h-6 text-green-600" />} label="Hired" value={summary?.hired ?? 0} subtitle={`${formatPercentage(summary?.referralToHireRate ?? 0)} rate`} />
              <MetricCard icon={<XCircle className="w-6 h-6 text-red-600" />} label="Not Hired" value={summary?.notHired ?? 0} />
              <MetricCard icon={<Mail className="w-6 h-6 text-orange-600" />} label="Emailed" value={summary?.emailed ?? 0} />
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card title="Referral -> Hire Funnel">
                <div className="space-y-3">
                  {funnelStages.map((stage) => {
                    const pct = funnel.referred > 0 ? (stage.count / funnel.referred) * 100 : 0;
                    return (
                      <div key={stage.label}>
                        <div className="flex justify-between text-sm mb-1">
                          <span className="text-gray-600">{stage.label}</span>
                          <span className="font-bold">{stage.count} ({pct.toFixed(1)}%)</span>
                        </div>
                        <div className="w-full bg-gray-100 rounded-full h-3">
                          <div className="h-3 rounded-full transition-all duration-500" style={{ width: `${pct}%`, backgroundColor: stage.color }} />
                        </div>
                      </div>
                    );
                  })}
                </div>
              </Card>

              <Card title="Bonus Overview">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <p className="text-sm text-gray-500">Expected</p>
                    <p className="text-xl font-bold text-gray-800">{formatCurrency(summary?.bonusExpected ?? 0)}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Remaining (receivable)</p>
                    <p className="text-xl font-bold text-amber-600">{formatCurrency(summary?.bonusRemaining ?? 0)}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Paid</p>
                    <p className="text-xl font-bold text-green-600">{formatCurrency(summary?.bonusPaid ?? 0)}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Disputed</p>
                    <p className="text-xl font-bold text-red-600">{formatCurrency(summary?.bonusDisputed ?? 0)}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2 mt-4 pt-4 border-t border-gray-100">
                  <DollarSign className="w-4 h-4 text-gray-400" />
                  <a href="/bonuses" className="text-sm text-primary-600 font-medium">View full bonus breakdown</a>
                </div>
              </Card>
            </div>

            <Card title="All Referrals">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-gray-200 text-left text-gray-600">
                      <th className="py-2 pr-4">Candidate</th>
                      <th className="py-2 pr-4">Platform</th>
                      <th className="py-2 pr-4">Account</th>
                      <th className="py-2 pr-4">Job</th>
                      <th className="py-2 pr-4">Status</th>
                      <th className="py-2 pr-4">Referral Date</th>
                      <th className="py-2 pr-4">Bonus</th>
                    </tr>
                  </thead>
                  <tbody>
                    {groupPageRows(pageRows).map((g) => {
                      const isOpen = expanded.has(g.key);
                      const [primary, ...rest] = g.jobs;
                      const rowsToShow = g.jobs.length === 1 || isOpen ? g.jobs : [primary];
                      return (
                        <Fragment key={g.key}>
                          {rowsToShow.map((r, i) => (
                            <tr key={r.referral_id} className="border-b border-gray-100">
                              <td className="py-2 pr-4 font-medium text-gray-800">{i === 0 ? g.candidate : ''}</td>
                              <td className="py-2 pr-4">{i === 0 ? g.platform : ''}</td>
                              <td className="py-2 pr-4">{i === 0 ? g.account : ''}</td>
                              <td className="py-2 pr-4">{r.job_title}</td>
                              <td className="py-2 pr-4">
                                <span className={`badge ${r.status === 'hired' ? 'badge-success' : r.status === 'not_hired' ? 'badge-danger' : r.status === 'applied' ? 'badge-info' : 'badge-warning'}`}>
                                  {r.status.replace('_', ' ')}
                                </span>
                              </td>
                              <td className="py-2 pr-4">{new Date(r.referral_date).toLocaleDateString()}</td>
                              <td className="py-2 pr-4">{r.bonus_amount ? `${formatCurrency(r.bonus_amount)} (${r.bonus_status})` : '-'}</td>
                            </tr>
                          ))}
                          {rest.length > 0 && (
                            <tr key={g.key + '-toggle'} className="border-b border-gray-100">
                              <td colSpan={7} className="py-1.5 pr-4">
                                <button
                                  onClick={() => setExpanded((prev) => {
                                    const next = new Set(prev);
                                    if (next.has(g.key)) next.delete(g.key); else next.add(g.key);
                                    return next;
                                  })}
                                  className="flex items-center gap-1 text-xs font-medium text-primary-600 hover:text-primary-700"
                                >
                                  <ChevronDown className={`w-3 h-3 transition-transform ${isOpen ? 'rotate-180' : ''}`} />
                                  {isOpen ? 'Show less' : `+${rest.length} more job${rest.length > 1 ? 's' : ''} for ${g.candidate}`}
                                </button>
                              </td>
                            </tr>
                          )}
                        </Fragment>
                      );
                    })}
                  </tbody>
                </table>
                {!pageLoading && pageRows.length === 0 && <p className="text-center text-gray-500 py-8">No referrals match these filters</p>}
              </div>

              {pageTotal > 0 && (
                <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm text-gray-600">
                  <span>
                    Showing {page * PAGE_SIZE + 1}-{Math.min((page + 1) * PAGE_SIZE, pageTotal)} of {pageTotal}
                  </span>
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => setPage((p) => Math.max(0, p - 1))}
                      disabled={page === 0 || pageLoading}
                      className="p-2 border border-gray-300 rounded-lg disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-50"
                      aria-label="Previous page"
                    >
                      <ChevronLeft className="w-4 h-4" />
                    </button>
                    <span>Page {page + 1} of {Math.max(1, Math.ceil(pageTotal / PAGE_SIZE))}</span>
                    <button
                      onClick={() => setPage((p) => (p + 1) * PAGE_SIZE < pageTotal ? p + 1 : p)}
                      disabled={(page + 1) * PAGE_SIZE >= pageTotal || pageLoading}
                      className="p-2 border border-gray-300 rounded-lg disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-50"
                      aria-label="Next page"
                    >
                      <ChevronRight className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              )}
            </Card>
          </>
        )}
      </div>
    </Layout>
  );
}
