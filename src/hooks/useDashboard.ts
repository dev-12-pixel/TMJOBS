'use client';
import { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';
import type { DashboardMetrics, ProfileMetrics, Client, JobProfile, Referral } from '../lib/types';

export function useDashboard(clientId: string | null) {
  const [metrics, setMetrics] = useState<DashboardMetrics | null>(null);
  const [profileMetrics, setProfileMetrics] = useState<ProfileMetrics[]>([]);
  const [clients, setClients] = useState<Client[]>([]);
  const [jobProfiles, setJobProfiles] = useState<JobProfile[]>([]);
  const [referrals, setReferrals] = useState<Referral[]>([]);
  const [loading, setLoading] = useState(true);
  const [dateRange, setDateRange] = useState<{ start: string; end: string } | null>(null);
  const [filterStatus, setFilterStatus] = useState<string | null>(null);

  useEffect(() => {
    if (!clientId) return;
    fetchDashboardData();
  }, [clientId, dateRange, filterStatus]);

  const fetchDashboardData = async () => {
    setLoading(true);
    try {
      const query = dateRange
        ? `created_at.gte.${dateRange.start}.created_at.lte.${dateRange.end}`
        : '';

      const [clientsRes, profilesRes, candidatesRes, referralsRes, paymentsRes] = await Promise.all([
        supabase.from('clients').select('*').eq('id', clientId),
        supabase.from('job_profiles').select('*').eq('client_id', clientId),
        supabase.from('candidates').select('*').in('job_profile_id', []),
        supabase.from('referrals').select('*').in('candidate_id', []),
        supabase.from('payments').select('*').in('referrer_id', []),
      ]);

      const profiles = profilesRes.data || [];
      const allCandidates = candidatesRes.data || [];
      const allReferrals = referralsRes.data || [];
      const allPayments = paymentsRes.data || [];

      const totalProfiles = profiles.length;
      const totalReferrals = allReferrals.length;
      const totalSignedUp = allReferrals.filter(r => r.status === 'signed_up').length;
      const totalHired = allReferrals.filter(r => r.status === 'hired').length;
      const totalNotHired = allReferrals.filter(r => r.status === 'not_hired').length;
      const totalEmailed = allReferrals.filter(r => r.status === 'emailed' ||
        allReferrals.some(ref => ref.id)).length;

      const totalReceivable = allPayments.reduce((sum, p) => sum + p.amount, 0);

      const receivableByProfile: Record<string, number> = {};
      const receivableByHire: Record<string, number> = {};

      profiles.forEach(p => {
        const profileHires = allReferrals.filter(r => r.job_profile_id === p.id && r.status === 'hired');
        receivableByProfile[p.title] = profileHires.length * p.referral_bonus_amount;
        profileHires.forEach(h => {
          const c = allCandidates.find(cand => cand.id === h.candidate_id);
          receivableByHire[c?.first_name + ' ' + c?.last_name || h.candidate_id] = p.referral_bonus_amount;
        });
      });

      const appliedToHiredRatio = totalReferrals > 0 ? (totalHired / totalReferrals) * 100 : 0;

      setMetrics({
        totalProfiles,
        totalReferrals,
        totalSignedUp,
        totalHired,
        totalNotHired,
        totalEmailed,
        appliedToHiredRatio,
        totalReceivable,
        receivableByProfile,
        receivableByHire,
      });

      const pm: ProfileMetrics[] = profiles.map(p => {
        const pReferrals = allReferrals.filter(r => r.job_profile_id === p.id);
        const pHired = pReferrals.filter(r => r.status === 'hired');
        const pNotHired = pReferrals.filter(r => r.status === 'not_hired');
        return {
          profileId: p.id,
          profileTitle: p.title,
          clientName: '',
          referralBonusAmount: p.referral_bonus_amount,
          candidateCount: pReferrals.length,
          appliedCount: pReferrals.filter(r => r.status === 'applied').length,
          signedUpCount: pReferrals.filter(r => r.status === 'signed_up').length,
          hiredCount: pHired.length,
          notHiredCount: pNotHired.length,
          emailedCount: 0,
          receivableAmount: pHired.length * p.referral_bonus_amount,
        };
      });

      setProfileMetrics(pm);
      setClients(clientsRes.data || []);
      setJobProfiles(profiles);
      setReferrals(allReferrals);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  const getFilteredReferrals = () => {
    let filtered = referrals;
    if (filterStatus) {
      filtered = filtered.filter(r => r.status === filterStatus);
    }
    if (dateRange) {
      filtered = filtered.filter(r => {
        const date = new Date(r.created_at);
        return date >= new Date(dateRange.start) && date <= new Date(dateRange.end);
      });
    }
    return filtered;
  };

  return {
    metrics,
    profileMetrics,
    clients,
    jobProfiles,
    referrals: getFilteredReferrals(),
    loading,
    dateRange,
    setDateRange,
    filterStatus,
    setFilterStatus,
    refresh: fetchDashboardData,
  };
}
