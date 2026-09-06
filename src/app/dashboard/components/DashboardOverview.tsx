'use client';
import { useDashboard } from '@/hooks/useDashboard';
import { useEffect } from 'react';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/MetricCard';
import { FilterBar } from '@/components/FilterBar';
import { ReferralTable } from '@/components/ReferralTable';
import { EarningsChart } from '@/components/EarningsChart';
import { formatCurrency, formatPercentage } from '@/lib/utils';
import { Briefcase, Users, CheckCircle, XCircle, Mail, DollarSign } from 'lucide-react';

interface DashboardOverviewProps {
  clientId: string;
  clientName: string;
}

export function DashboardOverview({ clientId, clientName }: DashboardOverviewProps) {
  const { metrics, profileMetrics, loading, dateRange, setDateRange, filterStatus, setFilterStatus } = useDashboard(clientId);

  if (loading) {
    return <div className="animate-pulse space-y-6"><div className="h-8 bg-gray-200 rounded w-48"></div><div className="grid grid-cols-4 gap-4"><div className="h-32 bg-gray-200 rounded-lg"></div><div className="h-32 bg-gray-200 rounded-lg"></div><div className="h-32 bg-gray-200 rounded-lg"></div><div className="h-32 bg-gray-200 rounded-lg"></div></div></div>;
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-3xl font-bold text-gray-800">{clientName}</h2>
        <div className="text-right">
          <p className="text-sm text-gray-500">Total Receivable</p>
          <p className="text-2xl font-bold text-green-600">{formatCurrency(metrics?.totalReceivable || 0)}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <MetricCard icon={<Briefcase className="w-6 h-6 text-blue-600" />} label="Active Profiles" value={metrics?.totalProfiles || 0} />
        <MetricCard icon={<Users className="w-6 h-6 text-green-600" />} label="Total Referrals" value={metrics?.totalReferrals || 0} />
        <MetricCard icon={<CheckCircle className="w-6 h-6 text-emerald-600" />} label="Hired" value={metrics?.totalHired || 0} subtitle={`${formatPercentage(metrics?.appliedToHiredRatio || 0)} ratio`} />
        <MetricCard icon={<DollarSign className="w-6 h-6 text-purple-600" />} label="Total Receivable" value={formatCurrency(metrics?.totalReceivable || 0)} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <MetricCard icon={<Users className="w-5 h-5 text-blue-500" />} label="Signed Up" value={metrics?.totalSignedUp || 0} />
        <MetricCard icon={<XCircle className="w-5 h-5 text-red-500" />} label="Not Hired" value={metrics?.totalNotHired || 0} />
        <MetricCard icon={<Mail className="w-5 h-5 text-orange-500" />} label="Emailed" value={metrics?.totalEmailed || 0} />
      </div>

      <FilterBar dateRange={dateRange} onDateRangeChange={setDateRange} statusFilter={filterStatus} onStatusFilterChange={setFilterStatus} clientFilter={clientId} onClientFilterChange={() => {}} profileFilter="all" onProfileFilterChange={() => {}} />

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card title="Earnings by Profile">
          <EarningsChart data={Object.entries(metrics?.receivableByProfile || {}).map(([label, amount]) => ({ label, amount }))} />
        </Card>
        <Card title="Earnings by Hire">
          <EarningsChart data={Object.entries(metrics?.receivableByHire || {}).map(([label, amount]) => ({ label, amount }))} />
        </Card>
      </div>

      <Card title={`Candidates - ${clientName}`}>
        <ReferralTable referrals={[]} />
      </Card>
    </div>
  );
}
