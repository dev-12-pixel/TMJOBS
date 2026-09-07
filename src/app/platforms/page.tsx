'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import Link from 'next/link';
import { Layout } from '@/components/Layout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { supabase } from '@/lib/supabase';
import type { Platform, ReferralDashboardRow } from '@/lib/types';
import { formatPercentage } from '@/lib/utils';
import { Plus } from 'lucide-react';

function slugify(name: string) {
  return name.toLowerCase().trim().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
}

export default function PlatformsPage() {
  const { session, loading: authLoading } = useAuth();
  const router = useRouter();
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [rows, setRows] = useState<ReferralDashboardRow[]>([]);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    if (!authLoading && !session) router.push('/');
  }, [session, authLoading, router]);

  useEffect(() => {
    if (session) load();
  }, [session]);

  const load = async () => {
    const [p, r] = await Promise.all([
      supabase.from('platforms').select('*').order('name'),
      supabase.from('vw_referral_dashboard').select('*'),
    ]);
    setPlatforms(p.data || []);
    setRows(r.data || []);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const name = formData.get('name') as string;
    await supabase.from('platforms').insert({ name, slug: slugify(name) });
    setShowForm(false);
    load();
  };

  const toggleActive = async (platform: Platform) => {
    await supabase.from('platforms').update({ active: !platform.active }).eq('id', platform.id);
    load();
  };

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Platforms</h2>
            <p className="text-gray-500">Where you refer candidates to - add a new one without touching code</p>
          </div>
          <Button onClick={() => setShowForm(!showForm)}><Plus className="w-4 h-4 mr-2 inline" />Add Platform</Button>
        </div>

        {showForm && (
          <Card title="Add Platform" className="max-w-md">
            <form onSubmit={handleSubmit} className="space-y-3">
              <input name="name" placeholder="Platform Name" required className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" />
              <Button type="submit">Add Platform</Button>
            </form>
          </Card>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {platforms.map((platform) => {
            const platformRows = rows.filter((r) => r.platform_id === platform.id);
            const hired = platformRows.filter((r) => r.status === 'hired').length;
            const hireRate = platformRows.length > 0 ? (hired / platformRows.length) * 100 : 0;
            return (
              <Card key={platform.id} title={platform.name}>
                <div className="space-y-2 text-sm">
                  <div className="flex justify-between"><span className="text-gray-500">Referrals</span><span className="font-medium">{platformRows.length}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Hired</span><span className="font-medium">{hired}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Hire Rate</span><span className="font-medium">{formatPercentage(hireRate)}</span></div>
                  <div className="flex items-center justify-between pt-2 border-t border-gray-100">
                    <span className={`badge ${platform.active ? 'badge-success' : 'badge-danger'}`}>{platform.active ? 'Active' : 'Inactive'}</span>
                    <Button variant="ghost" onClick={() => toggleActive(platform)}>{platform.active ? 'Deactivate' : 'Activate'}</Button>
                  </div>
                  <Link href={`/dashboard/platform/${platform.slug}`} className="block text-primary-600 text-sm font-medium pt-1">View dashboard →</Link>
                </div>
              </Card>
            );
          })}
        </div>
      </div>
    </Layout>
  );
}
