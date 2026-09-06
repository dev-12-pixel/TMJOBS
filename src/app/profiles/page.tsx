'use client';
import { useAuth } from '../../hooks/useAuth';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { Layout } from '../../components/Layout';
import { Card } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { supabase } from '../../lib/supabase';
import type { JobProfile, Client } from '../../lib/types';
import { Plus, Edit2, Trash2, Briefcase } from 'lucide-react';

export default function ProfilesPage() {
  const { session } = useAuth();
  const router = useRouter();
  const [profiles, setProfiles] = useState<JobProfile[]>([]);
  const [clients, setClients] = useState<Client[]>([]);
  const [showAddForm, setShowAddForm] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!session) {
      router.push('/');
      return;
    }
    fetchProfiles();
    fetchClients();
  }, [session]);

  const fetchProfiles = async () => {
    const { data } = await supabase.from('job_profiles').select('*');
    setProfiles(data || []);
    setLoading(false);
  };

  const fetchClients = async () => {
    const { data } = await supabase.from('clients').select('*');
    setClients(data || []);
  };

  if (!session) return null;

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-800">Job Profiles</h2>
            <p className="text-gray-500">Manage all job profiles across clients</p>
          </div>
          <Button onClick={() => setShowAddForm(!showAddForm)}>
            <Plus className="w-4 h-4 mr-2" />
            Add Profile
          </Button>
        </div>

        {showAddForm && (
          <Card title="Add New Job Profile" className="max-w-lg">
            <form onSubmit={async (e) => {
              e.preventDefault();
              const formData = new FormData(e.currentTarget);
              const { data, error } = await supabase.from('job_profiles').insert({
                client_id: formData.get('client_id'),
                title: formData.get('title'),
                description: formData.get('description'),
                location: formData.get('location'),
                salary_range: formData.get('salary_range'),
                referral_bonus_amount: parseFloat(formData.get('referral_bonus_amount') as string),
                status: 'active',
              });
              if (!error) {
                setShowAddForm(false);
                fetchProfiles();
              }
            }} className="space-y-4">
              <Input name="client_id" as="select" className="w-full">
                {clients.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
              </Input>
              <Input name="title" placeholder="Job Title" required />
              <Input name="description" placeholder="Description" />
              <Input name="location" placeholder="Location" />
              <Input name="salary_range" placeholder="Salary Range" />
              <Input name="referral_bonus_amount" type="number" placeholder="Referral Bonus ($)" required />
              <Button type="submit">Add Profile</Button>
            </form>
          </Card>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {profiles.map((profile) => (
            <Card key={profile.id} title={profile.title}>
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-500">Client</span>
                  <span className="font-medium">{clients.find(c => c.id === profile.client_id)?.name}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-500">Bonus</span>
                  <span className="font-medium text-green-600">${profile.referral_bonus_amount}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-500">Status</span>
                  <span className={`badge ${profile.status === 'active' ? 'badge-success' : 'badge-warning'}`}>
                    {profile.status}
                  </span>
                </div>
                <div className="flex gap-2 mt-4">
                  <Button variant="ghost" size="sm">Edit</Button>
                  <Button variant="ghost" size="sm">Delete</Button>
                </div>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </Layout>
  );
}
