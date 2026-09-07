'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import { formatCurrency } from '@/lib/utils';
import type { Platform, BonusRule, ReferralDashboardRow, BonusStatus } from '@/lib/types';

export default function BonusesPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [rules, setRules] = useState<BonusRule[]>([]);
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [platformFilter, setPlatformFilter] = useState('');

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (session) load();
  }, [session]);

  const load = async () => {
    const [p, r, rw] = await Promise.all([
      supabase.from('platforms').select('*').order('name'),
      supabase.from('bonus_rules').select('*').eq('active', true),
      supabase.from('vw_referral_dashboard').select('*').not('bonus_record_id', 'is', null),
    ]);
    setPlatforms(p.data || []);
    setRules(r.data || []);
    setRows(rw.data || []);
  };

  const updateRule = async (ruleId: string, amount: number, hours: number) => {
    await supabase.from('bonus_rules').update({ amount, hours_requirement: hours }).eq('id', ruleId);
    load();
  };

  const setBonusStatus = async (row: ReferralDashboardRow, status: BonusStatus) => {
    if (!row.bonus_record_id) return;
    if (status === 'paid') {
      await supabase.rpc('mark_bonus_paid', { p_bonus_record_id: row.bonus_record_id });
    } else {
      await supabase.from('bonus_records').update({ status }).eq('id', row.bonus_record_id);
    }
    load();
  };

  if (!session) return null;

  const filteredRows = rows.filter((r) => !platformFilter || r.platform_id === platformFilter);
  const totals = ['expected', 'remaining', 'paid', 'disputed'].map((status) => ({
    status,
    amount: filteredRows.filter((r) => r.bonus_status === status).reduce((sum, r) => sum + Number(r.bonus_amount || 0), 0),
  }));

  return (
    <Layout>
      <div className="space-y-6">
        <div>
          <h2 className="text-3xl font-bold text-gray-800">Bonuses</h2>
          <p className="text-gray-500">Bonus rules per platform, and every payable record</p>
        </div>

        <Card title="Bonus Rules">
          <p className="text-xs text-amber-700 bg-amber-50 border border-amber-200 rounded-lg p-2 mb-4">
            Amounts below were seeded as placeholders - correct them here to match your actual agreements.
          </p>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {rules.map((rule) => {
              const platform = platforms.find((p) => p.id === rule.platform_id);
              return (
                <div key={rule.id} className="border border-gray-200 rounded-lg p-4 space-y-2">
                  <p className="font-medium text-gray-800">{platform?.name}</p>
                  <label className="block text-xs text-gray-500">Amount (USD)</label>
                  <input type="number" defaultValue={rule.amount} onBlur={(e) => updateRule(rule.id, Number(e.target.value), rule.hours_requirement)} className="w-full px-2 py-1 border border-gray-300 rounded text-sm" />
                  <label className="block text-xs text-gray-500">Hours Required</label>
                  <input type="number" defaultValue={rule.hours_requirement} onBlur={(e) => updateRule(rule.id, rule.amount, Number(e.target.value))} className="w-full px-2 py-1 border border-gray-300 rounded text-sm" />
                  {rule.one_time_per_candidate && <p className="text-xs text-gray-500">One-time bonus per candidate</p>}
                </div>
              );
            })}
          </div>
        </Card>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {totals.map((t) => (
            <div key={t.status} className="metric-card">
              <p className="text-sm text-gray-500 capitalize">{t.status}</p>
              <p className="text-2xl font-bold text-gray-800">{formatCurrency(t.amount)}</p>
            </div>
          ))}
        </div>

        <Card title="Receivable by Hire">
          <select value={platformFilter} onChange={(e) => setPlatformFilter(e.target.value)} className="mb-4 px-3 py-2 border border-gray-300 rounded-lg text-sm">
            <option value="">All Platforms</option>
            {platforms.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
          </select>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-200 text-left text-gray-600">
                  <th className="py-2 pr-4">Candidate</th>
                  <th className="py-2 pr-4">Platform</th>
                  <th className="py-2 pr-4">Account</th>
                  <th className="py-2 pr-4">Amount</th>
                  <th className="py-2 pr-4">Status</th>
                </tr>
              </thead>
              <tbody>
                {filteredRows.map((r) => (
                  <tr key={r.referral_id} className="border-b border-gray-100">
                    <td className="py-2 pr-4 font-medium text-gray-800">{r.first_name} {r.last_name}</td>
                    <td className="py-2 pr-4">{r.platform_name}</td>
                    <td className="py-2 pr-4">{r.account_name}</td>
                    <td className="py-2 pr-4">{formatCurrency(r.bonus_amount || 0)}</td>
                    <td className="py-2 pr-4">
                      <select value={r.bonus_status || ''} onChange={(e) => setBonusStatus(r, e.target.value as BonusStatus)} className="px-2 py-1 border border-gray-300 rounded text-sm">
                        <option value="expected">Expected</option>
                        <option value="remaining">Remaining</option>
                        <option value="paid">Paid</option>
                        <option value="disputed">Disputed</option>
                      </select>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            {filteredRows.length === 0 && <p className="text-center text-gray-500 py-8">No bonus records yet</p>}
          </div>
        </Card>
      </div>
    </Layout>
  );
}
