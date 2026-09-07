'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import type { Platform, Account, Job, Candidate, ReferralDashboardRow, ReferralStatus } from '@/lib/types';
import { Plus } from 'lucide-react';

export default function ReferralsPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [jobs, setJobs] = useState<Job[]>([]);
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [showForm, setShowForm] = useState(false);
  const [formPlatform, setFormPlatform] = useState('');
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (!session) return;
    load();
    Promise.all([
      supabase.from('platforms').select('*').order('name'),
      supabase.from('accounts').select('*').order('name'),
      supabase.from('jobs').select('*').order('title'),
      supabase.from('candidates').select('*').order('first_name'),
    ]).then(([p, a, j, c]) => {
      setPlatforms(p.data || []);
      setAccounts(a.data || []);
      setJobs(j.data || []);
      setCandidates(c.data || []);
    });
  }, [session]);

  const load = async () => {
    const { data } = await supabase.from('vw_referral_dashboard').select('*').order('referral_date', { ascending: false });
    setRows(data || []);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    const formData = new FormData(e.currentTarget);
    const { error: insertError } = await supabase.from('referrals').insert({
      candidate_id: formData.get('candidate_id') as string,
      platform_id: formData.get('platform_id') as string,
      account_id: formData.get('account_id') as string,
      job_id: formData.get('job_id') as string,
    });
    if (insertError) {
      if (insertError.code === '23505') {
        setError('This candidate already has a referral for this platform + job. Edit the existing referral instead of creating a duplicate.');
      } else {
        setError(insertError.message);
      }
      return;
    }
    setShowForm(false);
    load();
  };

  const updateStatus = async (referralId: string, status: ReferralStatus) => {
    await supabase.from('referrals').update({ status }).eq('id', referralId);
    load();
  };

  const updateHours = async (referralId: string, hours: number) => {
    await supabase.from('referrals').update({ hours_completed: hours }).eq('id', referralId);
    load();
  };

  if (!session) return null;

  const filteredAccounts = accounts.filter((a) => !formPlatform || a.platform_id === formPlatform);
  const filteredJobs = jobs.filter((j) => !formPlatform || j.platform_id === formPlatform);

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Referrals</h2>
            <p className="text-gray-500">Every referral event: candidate + platform + account + job</p>
          </div>
          <Button onClick={() => setShowForm(!showForm)}><Plus className="w-4 h-4 mr-2 inline" />New Referral</Button>
        </div>

        {showForm && (
          <Card title="New Referral" className="max-w-2xl">
            {error && <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">{error}</div>}
            <form onSubmit={handleSubmit} className="space-y-3">
              <select name="candidate_id" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Candidate</option>
                {candidates.map((c) => <option key={c.id} value={c.id}>{c.first_name} {c.last_name}</option>)}
              </select>
              <select name="platform_id" required value={formPlatform} onChange={(e) => setFormPlatform(e.target.value)} className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Platform</option>
                {platforms.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
              <select name="account_id" required disabled={!formPlatform} className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Referral Account</option>
                {filteredAccounts.map((a) => <option key={a.id} value={a.id}>{a.name}</option>)}
              </select>
              <select name="job_id" required disabled={!formPlatform} className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Job</option>
                {filteredJobs.map((j) => <option key={j.id} value={j.id}>{j.title}</option>)}
              </select>
              <Button type="submit">Create Referral</Button>
            </form>
          </Card>
        )}

        <Card>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-200 text-left text-gray-600">
                  <th className="py-2 pr-4">Candidate</th>
                  <th className="py-2 pr-4">Platform</th>
                  <th className="py-2 pr-4">Account</th>
                  <th className="py-2 pr-4">Job</th>
                  <th className="py-2 pr-4">Status</th>
                  <th className="py-2 pr-4">Hours</th>
                  <th className="py-2 pr-4">Bonus</th>
                </tr>
              </thead>
              <tbody>
                {rows.map((r) => (
                  <tr key={r.referral_id} className="border-b border-gray-100">
                    <td className="py-2 pr-4 font-medium text-gray-800">
                      <a href={`/candidates/${r.candidate_id}`} className="hover:text-primary-600">{r.first_name} {r.last_name}</a>
                    </td>
                    <td className="py-2 pr-4">{r.platform_name}</td>
                    <td className="py-2 pr-4">{r.account_name}</td>
                    <td className="py-2 pr-4">{r.job_title}</td>
                    <td className="py-2 pr-4">
                      <select
                        value={r.status}
                        onChange={(e) => updateStatus(r.referral_id, e.target.value as ReferralStatus)}
                        className="px-2 py-1 border border-gray-300 rounded text-sm"
                      >
                        <option value="referred">Referred</option>
                        <option value="applied">Applied</option>
                        <option value="hired">Hired</option>
                        <option value="not_hired">Not Hired</option>
                      </select>
                    </td>
                    <td className="py-2 pr-4">
                      <input
                        type="number"
                        defaultValue={r.hours_completed}
                        onBlur={(e) => updateHours(r.referral_id, Number(e.target.value))}
                        className="w-16 px-2 py-1 border border-gray-300 rounded text-sm"
                      />
                    </td>
                    <td className="py-2 pr-4">{r.bonus_amount ? `$${r.bonus_amount} (${r.bonus_status})` : '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            {rows.length === 0 && <p className="text-center text-gray-500 py-8">No referrals yet</p>}
          </div>
        </Card>
      </div>
    </Layout>
  );
}
