'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import type { Platform, Job } from '@/lib/types';
import { Plus } from 'lucide-react';

export default function JobsPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [jobs, setJobs] = useState<Job[]>([]);
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (session) load();
  }, [session]);

  const load = async () => {
    const [j, p] = await Promise.all([
      supabase.from('jobs').select('*').order('title'),
      supabase.from('platforms').select('*').order('name'),
    ]);
    setJobs(j.data || []);
    setPlatforms(p.data || []);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    await supabase.from('jobs').insert({
      platform_id: formData.get('platform_id') as string,
      title: formData.get('title') as string,
      job_url: (formData.get('job_url') as string) || null,
    });
    setShowForm(false);
    load();
  };

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Jobs</h2>
            <p className="text-gray-500">Job postings per platform</p>
          </div>
          <Button onClick={() => setShowForm(!showForm)}><Plus className="w-4 h-4 mr-2 inline" />Add Job</Button>
        </div>

        {showForm && (
          <Card title="Add Job" className="max-w-lg">
            <form onSubmit={handleSubmit} className="space-y-3">
              <select name="platform_id" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm">
                <option value="">Select Platform</option>
                {platforms.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
              <input name="title" placeholder="Job Title" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <input name="job_url" placeholder="Job URL (optional)" className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <Button type="submit">Add Job</Button>
            </form>
          </Card>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {jobs.map((job) => (
            <Card key={job.id} title={job.title}>
              <div className="flex items-center justify-between text-sm">
                <span className="text-gray-500">Platform</span>
                <span className="font-medium">{platforms.find((p) => p.id === job.platform_id)?.name}</span>
              </div>
              <div className="flex items-center justify-between text-sm mt-2">
                <span className="text-gray-500">Status</span>
                <span className={`badge ${job.active ? 'badge-success' : 'badge-warning'}`}>{job.active ? 'active' : 'inactive'}</span>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </Layout>
  );
}
