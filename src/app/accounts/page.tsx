'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import { formatPercentage } from '@/lib/utils';
import type { Platform, Account, ReferralDashboardRow } from '@/lib/types';
import { Plus } from 'lucide-react';

export default function AccountsPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (session) load();
  }, [session]);

  const load = async () => {
    const [p, a, r] = await Promise.all([
      supabase.from('platforms').select('*').order('name'),
      supabase.from('accounts').select('*').order('name'),
      supabase.from('vw_referral_dashboard').select('*'),
    ]);
    setPlatforms(p.data || []);
    setAccounts(a.data || []);
    setRows(r.data || []);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    await supabase.from('accounts').insert({
      platform_id: formData.get('platform_id') as string,
      name: formData.get('name') as string,
      email: (formData.get('email') as string) || null,
      identifier: (formData.get('identifier') as string) || null,
    });
    setShowForm(false);
    load();
  };

  const toggleActive = async (account: Account) => {
    await supabase.from('accounts').update({ active: !account.active }).eq('id', account.id);
    load();
  };

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Referral Accounts</h2>
            <p className="text-gray-500">The profiles/logins you actually refer candidates through</p>
          </div>
          <Button onClick={() => setShowForm(!showForm)}><Plus className="w-4 h-4 mr-2 inline" />Add Account</Button>
        </div>

        {showForm && (
          <Card title="Add Referral Account" className="max-w-lg">
            <form onSubmit={handleSubmit} className="space-y-3">
              <select name="platform_id" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Platform</option>
                {platforms.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
              <input name="name" placeholder="Account Name (e.g. Turing Account 4)" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <input name="email" placeholder="Account Email" className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <input name="identifier" placeholder="Identifier (optional)" className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <Button type="submit">Add Account</Button>
            </form>
          </Card>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {accounts.map((account) => {
            const platform = platforms.find((p) => p.id === account.platform_id);
            const accountRows = rows.filter((r) => r.account_id === account.id);
            const hired = accountRows.filter((r) => r.status === 'hired').length;
            const hireRate = accountRows.length > 0 ? (hired / accountRows.length) * 100 : 0;
            return (
              <Card key={account.id} title={account.name}>
                <div className="space-y-2 text-sm">
                  <div className="flex justify-between"><span className="text-gray-500">Platform</span><span className="font-medium">{platform?.name}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Referrals</span><span className="font-medium">{accountRows.length}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Hired</span><span className="font-medium">{hired}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Hire Rate</span><span className="font-medium">{formatPercentage(hireRate)}</span></div>
                  <div className="flex justify-between items-center pt-2 border-t border-gray-100">
                    <span className={`badge ${account.active ? 'badge-success' : 'badge-danger'}`}>{account.active ? 'Active' : 'Inactive'}</span>
                    <Button variant="ghost" onClick={() => toggleActive(account)}>{account.active ? 'Deactivate' : 'Activate'}</Button>
                  </div>
                </div>
              </Card>
            );
          })}
        </div>
      </div>
    </Layout>
  );
}
