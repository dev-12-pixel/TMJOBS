'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter, useParams } from 'next/navigation';
import { useEffect, useState, useCallback } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import { formatCurrency } from '@/lib/utils';
import type { Candidate, ReferralDashboardRow, Email, ReferralStatusHistory } from '@/lib/types';
import { Mail, Phone, Linkedin } from 'lucide-react';

export default function CandidateDetailPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const params = useParams<{ id: string }>();
  const [candidate, setCandidate] = useState<Candidate | null>(null);
  const [referrals, setReferrals] = useState<ReferralDashboardRow[]>([]);
  const [emails, setEmails] = useState<Email[]>([]);
  const [history, setHistory] = useState<Record<string, ReferralStatusHistory[]>>({});
  const [showEmailForm, setShowEmailForm] = useState(false);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  const load = useCallback(async () => {
    const [{ data: cand }, { data: refs }, { data: mail }] = await Promise.all([
      supabase.from('candidates').select('*').eq('id', params.id).maybeSingle(),
      supabase.from('vw_referral_dashboard').select('*').eq('candidate_id', params.id),
      supabase.from('emails').select('*').eq('candidate_id', params.id).order('sent_at', { ascending: false }),
    ]);
    setCandidate(cand);
    setReferrals(refs || []);
    setEmails(mail || []);

    if (refs && refs.length > 0) {
      const { data: hist } = await supabase
        .from('referral_status_history')
        .select('*')
        .in('referral_id', refs.map((r) => r.referral_id))
        .order('changed_at');
      const grouped: Record<string, ReferralStatusHistory[]> = {};
      (hist || []).forEach((h) => {
        grouped[h.referral_id] = grouped[h.referral_id] || [];
        grouped[h.referral_id].push(h);
      });
      setHistory(grouped);
    }
  }, [params.id]);

  useEffect(() => {
    if (session) load();
  }, [session, load]);

  const logEmail = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    await supabase.from('emails').insert({
      candidate_id: params.id,
      direction: formData.get('direction') as string,
      email_type: formData.get('email_type') as string,
      subject: (formData.get('subject') as string) || null,
    });
    setShowEmailForm(false);
    load();
  };

  if (!session || !candidate) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div>
          <h2 className="text-3xl font-bold text-gray-800">{candidate.first_name} {candidate.last_name}</h2>
          <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
            {candidate.email && <span className="flex items-center gap-1"><Mail className="w-4 h-4" />{candidate.email}</span>}
            {candidate.phone && <span className="flex items-center gap-1"><Phone className="w-4 h-4" />{candidate.phone}</span>}
            {candidate.linkedin_url && (
              <a href={candidate.linkedin_url} target="_blank" rel="noreferrer" className="flex items-center gap-1 text-primary-600">
                <Linkedin className="w-4 h-4" />LinkedIn
              </a>
            )}
          </div>
        </div>

        <Card title="Referrals">
          <div className="space-y-4">
            {referrals.map((r) => (
              <div key={r.referral_id} className="border border-gray-200 rounded-lg p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="font-medium text-gray-800">{r.platform_name} - {r.job_title}</p>
                    <p className="text-sm text-gray-500">via {r.account_name}</p>
                  </div>
                  <span className={`badge ${r.status === 'hired' ? 'badge-success' : r.status === 'not_hired' ? 'badge-danger' : r.status === 'applied' ? 'badge-info' : 'badge-warning'}`}>
                    {r.status.replace('_', ' ')}
                  </span>
                </div>
                <div className="mt-3 space-y-1">
                  {(history[r.referral_id] || []).map((h) => (
                    <p key={h.id} className="text-xs text-gray-500">
                      {new Date(h.changed_at).toLocaleDateString()} — {h.old_status ? `${h.old_status} → ${h.new_status}` : `Created as ${h.new_status}`}
                    </p>
                  ))}
                </div>
                {r.bonus_amount != null && (
                  <p className="mt-3 text-sm">
                    Bonus: <span className="font-medium">{formatCurrency(r.bonus_amount)}</span>{' '}
                    <span className="text-gray-500">({r.bonus_status})</span>
                  </p>
                )}
              </div>
            ))}
            {referrals.length === 0 && <p className="text-gray-500 text-sm">No referrals yet for this candidate.</p>}
          </div>
        </Card>

        <Card title="Emails">
          <div className="flex justify-end mb-3">
            <Button variant="ghost" onClick={() => setShowEmailForm(!showEmailForm)}>Log Email</Button>
          </div>
          {showEmailForm && (
            <form onSubmit={logEmail} className="grid grid-cols-3 gap-2 mb-4">
              <select name="direction" className="px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="sent">Sent</option>
                <option value="received">Received</option>
              </select>
              <select name="email_type" className="px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="initial_contact">Initial Contact</option>
                <option value="follow_up">Follow-up</option>
                <option value="reminder">Reminder</option>
                <option value="status_update">Status Update</option>
                <option value="reply">Reply</option>
                <option value="other">Other</option>
              </select>
              <input name="subject" placeholder="Subject" className="px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <Button type="submit" className="col-span-3">Save</Button>
            </form>
          )}
          <div className="space-y-2">
            {emails.map((e) => (
              <div key={e.id} className="flex justify-between text-sm border-b border-gray-100 pb-2">
                <span>{e.subject || e.email_type} ({e.direction})</span>
                <span className="text-gray-500">{new Date(e.sent_at).toLocaleDateString()}</span>
              </div>
            ))}
            {emails.length === 0 && <p className="text-gray-500 text-sm">No emails logged yet.</p>}
          </div>
        </Card>
      </div>
    </Layout>
  );
}
