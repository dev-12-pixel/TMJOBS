export interface Client {
  id: string;
  name: string;
  logo_url: string | null;
  description: string | null;
  website_url: string | null;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface JobProfile {
  id: string;
  client_id: string;
  title: string;
  description: string | null;
  location: string | null;
  salary_range: string | null;
  referral_bonus_amount: number;
  status: string;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface Candidate {
  id: string;
  job_profile_id: string;
  first_name: string;
  last_name: string;
  email: string;
  phone: string | null;
  linkedin_url: string | null;
  resume_url: string | null;
  notes: string | null;
  source: string | null;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface Referral {
  id: string;
  candidate_id: string;
  referrer_id: string;
  job_profile_id: string;
  status: 'applied' | 'signed_up' | 'hired' | 'not_hired';
  applied_at: string;
  signed_up_at: string | null;
  hired_at: string | null;
  not_hired_at: string | null;
  hired_by: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface TrackingEvent {
  id: string;
  referral_id: string;
  event_type: 'applied' | 'signed_up' | 'hired' | 'not_hired' | 'emailed';
  event_date: string;
  metadata: Record<string, unknown> | null;
  created_at: string;
}

export interface Payment {
  id: string;
  referral_id: string;
  candidate_id: string;
  job_profile_id: string;
  client_id: string;
  referrer_id: string;
  amount: number;
  currency: string;
  status: 'pending' | 'paid' | 'overdue';
  paid_at: string | null;
  payment_method: string | null;
  invoice_number: string | null;
  created_at: string;
  updated_at: string;
}

export interface DashboardMetrics {
  totalProfiles: number;
  totalReferrals: number;
  totalSignedUp: number;
  totalHired: number;
  totalNotHired: number;
  totalEmailed: number;
  appliedToHiredRatio: number;
  totalReceivable: number;
  receivableByProfile: Record<string, number>;
  receivableByHire: Record<string, number>;
}

export interface ProfileMetrics {
  profileId: string;
  profileTitle: string;
  clientName: string;
  referralBonusAmount: number;
  candidateCount: number;
  appliedCount: number;
  signedUpCount: number;
  hiredCount: number;
  notHiredCount: number;
  emailedCount: number;
  receivableAmount: number;
}
