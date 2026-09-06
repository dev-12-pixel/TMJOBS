'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect } from 'react';
import { Layout } from '@/components/Layout';
import { DashboardOverview } from '@/app/dashboard/components/DashboardOverview';
import { Card } from '@/components/ui/Card';
import {
  Users,
  Briefcase,
  TrendingUp,
  DollarSign,
  CheckCircle,
  XCircle,
  Mail,
} from 'lucide-react';

export default function DashboardPage() {
  const { session } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!session) {
      router.push('/');
    }
  }, [session, router]);

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6 animate-fade-in">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Dashboard Overview</h2>
            <p className="text-gray-500 mt-1">Track all your referral metrics across clients</p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <MetricCard icon={Briefcase} label="Active Profiles" value="4" change="+2 this month" color="blue" />
          <MetricCard icon={Users} label="Total Referrals" value="48" change="+12 this month" color="green" />
          <MetricCard icon={CheckCircle} label="Hired" value="15" change="+5 this month" color="success" />
          <MetricCard icon={DollarSign} label="Total Earnings" value="$3,450" change="+12% this month" color="purple" />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card title="Referral Funnel">
            <FunnelChart />
          </Card>
          <Card title="Hiring Conversion Rate">
            <ConversionChart />
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <Card title="Top Clients" className="lg:col-span-2">
            <ClientTable />
          </Card>
          <Card title="Recent Activity">
            <ActivityFeed />
          </Card>
        </div>
      </div>
    </Layout>
  );
}

function MetricCard({
  icon: Icon,
  label,
  value,
  change,
  color,
}: {
  icon: any;
  label: string;
  value: string;
  change: string;
  color: string;
}) {
  const colorMap = {
    blue: 'bg-blue-50 text-blue-600',
    green: 'bg-green-50 text-green-600',
    success: 'bg-emerald-50 text-emerald-600',
    purple: 'bg-purple-50 text-purple-600',
  };

  return (
    <div className="metric-card">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm font-medium text-gray-600">{label}</p>
          <p className="text-3xl font-bold text-gray-800 mt-2">{value}</p>
          <p className="text-xs text-green-600 mt-1">{change}</p>
        </div>
        <div className={`w-12 h-12 rounded-lg flex items-center justify-center ${colorMap[color as keyof typeof colorMap]}`}>
          <Icon className="w-6 h-6" />
        </div>
      </div>
    </div>
  );
}

function FunnelChart() {
  const stages = [
    { label: 'Applied', count: 48, color: '#3b82f6' },
    { label: 'Signed Up', count: 32, color: '#10b981' },
    { label: 'Hired', count: 15, color: '#22c55e' },
    { label: 'Not Hired', count: 17, color: '#ef4444' },
  ];

  const max = 48;

  return (
    <div className="space-y-3">
      {stages.map((stage) => (
        <div key={stage.label}>
          <div className="flex justify-between text-sm mb-1">
            <span className="text-gray-600">{stage.label}</span>
            <span className="font-bold">{stage.count}</span>
          </div>
          <div className="w-full bg-gray-100 rounded-full h-3">
            <div
              className="h-3 rounded-full transition-all duration-500"
              style={{
                width: `${(stage.count / max) * 100}%`,
                backgroundColor: stage.color,
              }}
            />
          </div>
        </div>
      ))}
    </div>
  );
}

function ConversionChart() {
  const data = [
    { month: 'Jan', rate: 31.3 },
    { month: 'Feb', rate: 34.2 },
    { month: 'Mar', rate: 28.9 },
    { month: 'Apr', rate: 37.5 },
    { month: 'May', rate: 42.1 },
    { month: 'Jun', rate: 38.7 },
  ];

  return (
    <div className="h-64 flex items-end gap-2">
      {data.map((d) => (
        <div key={d.month} className="flex-1 flex flex-col items-center gap-1">
          <span className="text-xs font-medium text-gray-600">{d.rate}%</span>
          <div
            className="w-full bg-primary-500 rounded-t-md transition-all duration-500 hover:bg-primary-600"
            style={{ height: `${d.rate * 2.5}%` }}
          />
          <span className="text-xs text-gray-400">{d.month}</span>
        </div>
      ))}
    </div>
  );
}

function ClientTable() {
  const clients = [
    { name: 'Major Turing', profiles: 3, candidates: 28, hires: 12, revenue: '$2,400' },
    { name: 'Micro1', profiles: 2, candidates: 20, hires: 8, revenue: '$1,050' },
  ];

  return (
    <div className="space-y-3">
      {clients.map((client) => (
        <div key={client.name} className="flex items-center justify-between p-3 rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors">
          <div>
            <p className="font-medium text-gray-800">{client.name}</p>
            <p className="text-sm text-gray-500">{client.profiles} profiles • {client.candidates} candidates</p>
          </div>
          <div className="text-right">
            <p className="font-bold text-green-600">{client.revenue}</p>
            <p className="text-sm text-gray-500">{client.hires} hired</p>
          </div>
        </div>
      ))}
    </div>
  );
}

function ActivityFeed() {
  const activities = [
    { text: 'John hired at Major Turing', time: '2h ago', type: 'hired' },
    { text: 'Sarah signed up for Micro1', time: '5h ago', type: 'signed_up' },
    { text: 'Mike applied to Senior Dev', time: '1d ago', type: 'applied' },
    { text: 'Payment received: $300', time: '2d ago', type: 'payment' },
  ];

  const typeColors = {
    hired: 'bg-green-100 text-green-800',
    signed_up: 'bg-blue-100 text-blue-800',
    applied: 'bg-yellow-100 text-yellow-800',
    payment: 'bg-purple-100 text-purple-800',
  };

  return (
    <div className="space-y-3">
      {activities.map((activity, i) => (
        <div key={i} className="flex items-center gap-3">
          <span className={`badge ${typeColors[activity.type as keyof typeof typeColors]}`}>
            {activity.type.replace('_', ' ')}
          </span>
          <p className="text-sm text-gray-700 flex-1">{activity.text}</p>
          <span className="text-xs text-gray-400">{activity.time}</span>
        </div>
      ))}
    </div>
  );
}
