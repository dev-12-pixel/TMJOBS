'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState, useCallback } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/MetricCard';
import { supabase } from '@/lib/supabase';
import { fetchDashboardRows, fetchAccounts, summarizeDashboard, funnelCounts } from '@/lib/services/dashboard';
import { formatCurrency, formatPercentage } from '@/lib/utils';
import type { Platform, DashboardSummary, ReferralDashboardRow } from '@/lib/types';
import { Users, Briefcase, CheckCircle, XCircle, Mail, DollarSign } from 'lucide-react';

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

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    supabase.from('platforms').select('*').order('name').then(({ data }) => setPlatforms(data || []));
  }, []);

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const filters = { platformId: platformId || undefined, dateFrom: dateFrom || undefined, dateTo: dateTo || undefined };
      const [dashboardRows, accounts] = await Promise.all([fetchDashboardRows(filters), fetchAccounts(platformId || undefined)]);
      setRows(dashboardRows);
      setSummary(summarizeDashboard(dashboardRows, accounts.length));
    } finally {
      setLoading(false);
    }
  }, [platformId, dateFrom, dateTo]);

  useEffect(() => {
    if (session) load();
  }, [session, load]);

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

            <Card title="Recent Referrals">
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
                    {rows
                      .slice()
                      .sort((a, b) => new Date(b.referral_date).getTime() - new Date(a.referral_date).getTime())
                      .slice(0, 20)
                      .map((r) => (
                        <tr key={r.referral_id} className="border-b border-gray-100">
                          <td className="py-2 pr-4 font-medium text-gray-800">{r.first_name} {r.last_name}</td>
                          <td className="py-2 pr-4">{r.platform_name}</td>
                          <td className="py-2 pr-4">{r.account_name}</td>
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
                  </tbody>
                </table>
                {rows.length === 0 && <p className="text-center text-gray-500 py-8">No referrals match these filters</p>}
              </div>
            </Card>
          </>
        )}
      </div>
    </Layout>
  );
}
