'use client';
import { useAuth } from '../../hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '../../components/Layout';
import { Card } from '../../components/ui/Card';
import { supabase } from '../../lib/supabase';
import type { Candidate, JobProfile } from '../../lib/types';
import { Search, UserPlus, Mail } from 'lucide-react';

export default function CandidatesPage() {
  const { session } = useAuth();
  const router = useRouter();
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [profiles, setProfiles] = useState<JobProfile[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!session) {
      router.push('/');
      return;
    }
    fetchCandidates();
    fetchProfiles();
  }, [session]);

  const fetchCandidates = async () => {
    const { data } = await supabase.from('candidates').select('*');
    setCandidates(data || []);
    setLoading(false);
  };

  const fetchProfiles = async () => {
    const { data } = await supabase.from('job_profiles').select('*');
    setProfiles(data || []);
  };

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Candidates</h2>
            <p className="text-gray-500">Track all referred candidates</p>
          </div>
          <Button><UserPlus className="w-4 h-4 mr-2" />Add Candidate</Button>
        </div>

        <Card>
          <div className="flex items-center gap-4 mb-4">
            <Search className="w-5 h-5 text-gray-400" />
            <input type="text" placeholder="Search candidates..." className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none" />
          </div>
          <div className="space-y-3">
            {candidates.map((candidate) => {
              const profile = profiles.find(p => p.id === candidate.job_profile_id);
              return (
                <div key={candidate.id} className="flex items-center justify-between p-4 rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors">
                  <div>
                    <p className="font-medium text-gray-800">{candidate.first_name} {candidate.last_name}</p>
                    <p className="text-sm text-gray-500">{candidate.email} • {profile?.title || 'Unknown Profile'}</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <button className="p-2 text-gray-500 hover:text-primary-600"><Mail className="w-4 h-4" /></button>
                  </div>
                </div>
              );
            })}
          </div>
        </Card>
      </div>
    </Layout>
  );
}
