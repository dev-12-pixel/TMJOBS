'use client';
import { useAuth } from '../../../hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '../../../components/Layout';
import { Card } from '../../../components/ui/Card';
import { MetricCard } from '../../../components/MetricCard';
import { FilterBar } from '../../../components/FilterBar';
import { ReferralTable } from '../../../components/ReferralTable';
import { EarningsChart } from '../../../components/EarningsChart';
import { formatCurrency, formatPercentage } from '../../../lib/utils';
import {
  Briefcase,
  Users,
  CheckCircle,
  XCircle,
  Mail,
  TrendingUp,
  DollarSign,
  ArrowRight,
} from 'lucide-react';
import type { JobProfile, Referral } from '../../../lib/types';
import { supabase } from '../../../lib/supabase';

const CLIENT_ID = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
const CLIENT_NAME = 'Major Turing';

export default function MajorTuringPage() {
  const { session } = useAuth();
  const router = useRouter();
  const [metrics, setMetrics] = useState<any>(null);
  const [profiles, setProfiles] = useState<JobProfile[]>([]);
  const [referrals, setReferrals] = useState<Referral[]>([]);
  const [loading, setLoading] = useState(true);
  const [dateRange, setDateRange] = useState<{ start: string; end: string } | null>(null);
  const [statusFilter, setStatusFilter] = useState<string | null>(null);

  useEffect(() => {
    if (!session) {
      router.push('/');
      return;
    }
    fetchData();
  }, [session, dateRange, statusFilter]);

  const fetchData = async () => {
    setLoading(true);
    try {
      const [profilesRes, candidatesRes, referralsRes, paymentsRes] = await Promise.all([
        supabase.from('job_profiles').select('*').eq('client_id', CLIENT_ID),
        supabase.from('candidates').select('*'),
        supabase.from('referrals').select('*'),
        supabase.from('payments').select('*'),
      ]);

      const allProfiles = profilesRes.data || [];
      const allCandidates = candidatesRes.data || [];
      const allReferrals = referralsRes.data || [];
      const allPayments = paymentsRes.data || [];

      const clientReferrals = allReferrals.filter(r => {
        const profile = allProfiles.find(p => p.id === r.job_profile_id);
        return profile && profile.client_id === CLIENT_ID;
      });

      const totalReferrals = clientReferrals.length;
      const totalHired = clientReferrals.filter(r => r.status === 'hired').length;
      const totalNotHired = clientReferrals.filter(r => r.status === 'not_hired').length;
      const totalSignedUp = clientReferrals.filter(r => r.status === 'signed_up').length;
      const totalEmailed = clientReferrals.filter(r => r.status === 'emailed' ||
        allReferrals.some(ref => ref.id)).length;
      const totalProfiles = allProfiles.filter(p => p.status === 'active').length;

      const totalReceivable = allPayments
        .filter(p => {
          const ref = allReferrals.find(r => r.id === p.referral_id);
          const prof = allProfiles.find(pr => pr.id === ref?.job_profile_id);
          return prof && prof.client_id === CLIENT_ID;
        })
        .reduce((sum, p) => sum + p.amount, 0);

      const appliedToHiredRatio = totalReferrals > 0 ? (totalHired / totalReferrals) * 100 : 0;

      const receivableByProfile: Record<string, number> = {};
      const receivableByHire: Record<string, number> = {};

      allProfiles.forEach(p => {
        const pHired = clientReferrals.filter(r => r.job_profile_id === p.id && r.status === 'hired');
        const profileAmount = pHired.length * p.referral_bonus_amount;
        receivableByProfile[p.title] = profileAmount;
        pHired.forEach(h => {
          const c = allCandidates.find(cand => cand.id === h.candidate_id);
          receivableByHire[c?.first_name + ' ' + c?.last_name || h.candidate_id] = p.referral_bonus_amount;
        });
      });

      setMetrics({
        totalProfiles,
        totalReferrals,
        totalSignedUp,
        totalHired,
        totalNotHired,
        totalEmailed,
        appliedToHiredRatio,
        totalReceivable,
        receivableByProfile,
        receivableByHire,
      });
      setProfiles(allProfiles);
      setReferrals(clientReferrals);
    } catch (error) {
      console.error('Error:', error);
    } finally {
      setLoading(false);
    }
  };

  if (!session) return null;

  const filteredReferrals = referrals.filter(r => {
    if (statusFilter && r.status !== statusFilter) return false;
    if (dateRange) {
      const d = new Date(r.created_at);
      if (d < new Date(dateRange.start) || d > new Date(dateRange.end)) return false;
    }
    return true;
  });

  return (
    <Layout>
      <div className="space-y-6 animate-fade-in">
        <div className="flex items-center justify-between">
          <div>
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-blue-600 rounded-xl flex items-center justify-center">
                <Briefcase className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-3xl font-bold text-gray-800">{CLIENT_NAME}</h2>
                <p className="text-gray-500">Premium Tech Recruitment</p>
              </div>
            </div>
          </div>
          <div className="text-right">
            <p className="text-sm text-gray-500">Total Earnings</p>
            <p className="text-2xl font-bold text-green-600">{formatCurrency(metrics?.totalReceivable || 0)}</p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <MetricCard
            icon={<Briefcase className="w-6 h-6 text-blue-600" />}
            label="Active Profiles"
            value={metrics?.totalProfiles || 0}
            subtitle="Currently recruiting"
          />
          <MetricCard
            icon={<Users className="w-6 h-6 text-green-600" />}
            label="Total Referrals"
            value={metrics?.totalReferrals || 0}
            subtitle="All candidates"
          />
          <MetricCard
            icon={<CheckCircle className="w-6 h-6 text-emerald-600" />}
            label="Hired"
            value={metrics?.totalHired || 0}
            subtitle={`${formatPercentage(metrics?.appliedToHiredRatio || 0)} rate`}
          />
          <MetricCard
            icon={<DollarSign className="w-6 h-6 text-purple-600" />}
            label="Total Receivable"
            value={formatCurrency(metrics?.totalReceivable || 0)}
            subtitle="Pending payments"
          />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <MetricCard
            icon={<Users className="w-5 h-5 text-blue-500" />}
            label="Signed Up"
            value={metrics?.totalSignedUp || 0}
          />
          <MetricCard
            icon={<XCircle className="w-5 h-5 text-red-500" />}
            label="Not Hired"
            value={metrics?.totalNotHired || 0}
          />
          <MetricCard
            icon={<Mail className="w-5 h-5 text-orange-500" />}
            label="Emailed"
            value={metrics?.totalEmailed || 0}
          />
        </div>

        <FilterBar
          dateRange={dateRange}
          onDateRangeChange={setDateRange}
          statusFilter={statusFilter}
          onStatusFilterChange={setStatusFilter}
          clientFilter="major-turing"
          onClientFilterChange={() => {}}
          profileFilter="all"
          onProfileFilterChange={() => {}}
        />

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card title="Referral Breakdown by Profile">
            {profiles.length > 0 ? (
              <EarningsChart
                data={Object.entries(metrics?.receivableByProfile || {}).map(([label, amount]) => ({
                  label,
                  amount,
                }))}
              />
            ) : (
              <p className="text-gray-500 text-center py-4">No profiles yet</p>
            )}
          </Card>

          <Card title="Hiring Conversion Funnel">
            <div className="space-y-3">
              {[
                { label: 'Applied', count: metrics?.totalReferrals || 0, pct: 100, color: '#3b82f6' },
                { label: 'Signed Up', count: metrics?.totalSignedUp || 0, pct: metrics?.totalReferrals ? (metrics.totalSignedUp / metrics.totalReferrals) * 100 : 0, color: '#10b981' },
                { label: 'Hired', count: metrics?.totalHired || 0, pct: metrics?.totalReferrals ? (metrics.totalHired / metrics.totalReferrals) * 100 : 0, color: '#22c55e' },
                { label: 'Not Hired', count: metrics?.totalNotHired || 0, pct: metrics?.totalReferrals ? (metrics.totalNotHired / metrics.totalReferrals) * 100 : 0, color: '#ef4444' },
              ].map((stage) => (
                <div key={stage.label}>
                  <div className="flex justify-between text-sm mb-1">
                    <span className="text-gray-600">{stage.label}</span>
                    <span className="font-bold">{stage.count} ({stage.pct.toFixed(1)}%)</span>
                  </div>
                  <div className="w-full bg-gray-100 rounded-full h-3">
                    <div
                      className="h-3 rounded-full transition-all duration-500"
                      style={{ width: `${stage.pct}%`, backgroundColor: stage.color }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </Card>
        </div>

        <Card title="All Candidates - {CLIENT_NAME}">
          <ReferralTable referrals={filteredReferrals} />
        </Card>
      </div>
    </Layout>
  );
}
