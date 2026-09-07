'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import Link from 'next/link';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { supabase } from '@/lib/supabase';
import { findPossibleDuplicates } from '@/lib/services/candidates';
import type { Candidate } from '@/lib/types';
import { Search, UserPlus, AlertTriangle } from 'lucide-react';

export default function CandidatesPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [search, setSearch] = useState('');
  const [showAddForm, setShowAddForm] = useState(false);
  const [duplicates, setDuplicates] = useState<Candidate[]>([]);
  const [pendingForm, setPendingForm] = useState<FormData | null>(null);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (session) fetchCandidates();
  }, [session]);

  const fetchCandidates = async () => {
    const { data } = await supabase.from('candidates').select('*').order('created_at', { ascending: false });
    setCandidates(data || []);
  };

  const createCandidate = async (formData: FormData) => {
    const { error } = await supabase.from('candidates').insert({
      first_name: formData.get('first_name') as string,
      last_name: formData.get('last_name') as string,
      email: (formData.get('email') as string) || null,
      phone: (formData.get('phone') as string) || null,
      linkedin_url: (formData.get('linkedin_url') as string) || null,
      notes: (formData.get('notes') as string) || null,
    });
    if (!error) {
      setShowAddForm(false);
      setPendingForm(null);
      setDuplicates([]);
      fetchCandidates();
    }
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const email = (formData.get('email') as string) || '';
    const phone = (formData.get('phone') as string) || '';
    const found = await findPossibleDuplicates(email, phone);
    if (found.length > 0) {
      setDuplicates(found);
      setPendingForm(formData);
    } else {
      await createCandidate(formData);
    }
  };

  if (!session) return null;

  const filtered = candidates.filter((c) => {
    const q = search.toLowerCase();
    return (
      !q ||
      `${c.first_name} ${c.last_name}`.toLowerCase().includes(q) ||
      c.email?.toLowerCase().includes(q) ||
      c.phone?.includes(q)
    );
  });

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Candidates</h2>
            <p className="text-gray-500">Every person you've referred, across every platform</p>
          </div>
          <Button onClick={() => setShowAddForm(!showAddForm)}><UserPlus className="w-4 h-4 mr-2 inline" />Add Candidate</Button>
        </div>

        {showAddForm && (
          <Card title="Add Candidate" className="max-w-lg">
            {duplicates.length > 0 ? (
              <div className="space-y-4">
                <div className="flex items-start gap-2 p-3 bg-amber-50 border border-amber-200 rounded-lg text-amber-800 text-sm">
                  <AlertTriangle className="w-5 h-5 shrink-0" />
                  <div>
                    <p className="font-medium">Possible existing candidate found:</p>
                    {duplicates.map((d) => (
                      <p key={d.id}>{d.first_name} {d.last_name} - {d.email || d.phone}</p>
                    ))}
                  </div>
                </div>
                <div className="flex gap-2">
                  <Button variant="secondary" onClick={() => router.push(`/candidates/${duplicates[0].id}`)}>Use Existing Candidate</Button>
                  <Button onClick={() => pendingForm && createCandidate(pendingForm)}>Continue Anyway</Button>
                </div>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-3">
                <div className="grid grid-cols-2 gap-3">
                  <Input name="first_name" placeholder="First Name" required />
                  <Input name="last_name" placeholder="Last Name" required />
                </div>
                <Input name="email" type="email" placeholder="Email" />
                <Input name="phone" placeholder="Phone" />
                <Input name="linkedin_url" placeholder="LinkedIn URL" />
                <Input name="notes" placeholder="Notes" />
                <Button type="submit">Add Candidate</Button>
              </form>
            )}
          </Card>
        )}

        <Card>
          <div className="flex items-center gap-4 mb-4">
            <Search className="w-5 h-5 text-gray-400" />
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Search by name, email, or phone..."
              className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            />
          </div>
          <div className="space-y-2">
            {filtered.map((candidate) => (
              <Link
                key={candidate.id}
                href={`/candidates/${candidate.id}`}
                className="flex items-center justify-between p-4 rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors"
              >
                <div>
                  <p className="font-medium text-gray-800">{candidate.first_name} {candidate.last_name}</p>
                  <p className="text-sm text-gray-500">{candidate.email || 'No email'} {candidate.phone ? `• ${candidate.phone}` : ''}</p>
                </div>
              </Link>
            ))}
            {filtered.length === 0 && <p className="text-center text-gray-500 py-8">No candidates found</p>}
          </div>
        </Card>
      </div>
    </Layout>
  );
}
