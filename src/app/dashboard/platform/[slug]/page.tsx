'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter, useParams } from 'next/navigation';
import { useEffect, useState, useCallback } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/MetricCard';
import { supabase } from '@/lib/supabase';
import { fetchDashboardRows, fetchAccounts, summarizeDashboard, groupByAccount } from '@/lib/services/dashboard';
import { formatCurrency, formatPercentage } from '@/lib/utils';
import type { Platform, DashboardSummary, ReferralDashboardRow, Account } from '@/lib/types';
import { Users, Briefcase, CheckCircle, XCircle, Mail } from 'lucide-react';

export default function PlatformDashboardPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const params = useParams<{ slug: string }>();
  const [platform, setPlatform] = useState<Platform | null>(null);
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  const load = useCallback(async () => {
    setLoading(true);
    const { data: platformRow } = await supabase.from('platforms').select('*').eq('slug', params.slug).maybeSingle();
    if (!platformRow) {
      setNotFound(true);
      setLoading(false);
      return;
    }
    setPlatform(platformRow);
    const [dashboardRows, platformAccounts] = await Promise.all([
      fetchDashboardRows({ platformId: platformRow.id }),
      fetchAccounts(platformRow.id),
    ]);
    setRows(dashboardRows);
    setAccounts(platformAccounts);
    setSummary(summarizeDashboard(dashboardRows, platformAccounts.length));
    setLoading(false);
  }, [params.slug]);

  useEffect(() => {
    if (session) load();
  }, [session, load]);

  if (!session) return null;
  if (notFound) {
    return (
      <Layout>
        <p className="text-gray-500">No platform found for &quot;{params.slug}&quot;.</p>
      </Layout>
    );
  }

  const accountStats = groupByAccount(rows, accounts);

  return (
    <Layout>
      <div className="space-y-6 animate-fade-in">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 bg-primary-600 rounded-xl flex items-center justify-center">
            <Briefcase className="w-6 h-6 text-white" />
          </div>
          <div>
            <h2 className="text-3xl font-bold text-gray-800">{platform?.name ?? '...'}</h2>
            <p className="text-gray-500">{accounts.length} referral account{accounts.length === 1 ? '' : 's'}</p>
          </div>
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

            <Card title="Receivable">
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <p className="text-sm text-gray-500">Remaining (receivable)</p>
                  <p className="text-2xl font-bold text-amber-600">{formatCurrency(summary?.bonusRemaining ?? 0)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-500">Paid</p>
                  <p className="text-2xl font-bold text-green-600">{formatCurrency(summary?.bonusPaid ?? 0)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-500">Expected</p>
                  <p className="text-2xl font-bold text-gray-800">{formatCurrency(summary?.bonusExpected ?? 0)}</p>
                </div>
              </div>
            </Card>

            <Card title="Performance by Referral Account">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-gray-200 text-left text-gray-600">
                      <th className="py-2 pr-4">Account</th>
                      <th className="py-2 pr-4">Referrals</th>
                      <th className="py-2 pr-4">Hired</th>
                      <th className="py-2 pr-4">Hire Rate</th>
                      <th className="py-2 pr-4">Bonus Total</th>
                    </tr>
                  </thead>
                  <tbody>
                    {accountStats.map(({ account, referrals, hired, hireRate, bonusTotal }) => (
                      <tr key={account.id} className="border-b border-gray-100">
                        <td className="py-2 pr-4 font-medium text-gray-800">{account.name}</td>
                        <td className="py-2 pr-4">{referrals}</td>
                        <td className="py-2 pr-4">{hired}</td>
                        <td className="py-2 pr-4">{formatPercentage(hireRate)}</td>
                        <td className="py-2 pr-4">{formatCurrency(bonusTotal)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </Card>
          </>
        )}
      </div>
    </Layout>
  );
}
