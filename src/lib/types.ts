export type ReferralStatus = 'referred' | 'applied' | 'hired' | 'not_hired';
export type BonusStatus = 'expected' | 'remaining' | 'paid' | 'disputed';
export type EmailDirection = 'sent' | 'received';
export type EmailType = 'initial_contact' | 'follow_up' | 'reminder' | 'status_update' | 'reply' | 'other';

export interface Platform {
  id: string;
  name: string;
  slug: string;
  active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Account {
  id: string;
  platform_id: string;
  name: string;
  email: string | null;
  identifier: string | null;
  active: boolean;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface Job {
  id: string;
  platform_id: string;
  title: string;
  external_job_id: string | null;
  job_url: string | null;
  active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Candidate {
  id: string;
  first_name: string;
  last_name: string;
  email: string | null;
  phone: string | null;
  linkedin_url: string | null;
  resume_url: string | null;
  notes: string | null;
  intro: string | null;
  primary_skills: string | null;
  secondary_skills: string | null;
  source: 'manual' | 'google_form';
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface Referral {
  id: string;
  candidate_id: string;
  platform_id: string;
  account_id: string;
  job_id: string;
  status: ReferralStatus;
  referral_date: string;
  applied_at: string | null;
  hired_at: string | null;
  not_hired_at: string | null;
  hours_completed: number;
  notes: string | null;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface ReferralStatusHistory {
  id: string;
  referral_id: string;
  old_status: ReferralStatus | null;
  new_status: ReferralStatus;
  changed_at: string;
  notes: string | null;
}

export interface Email {
  id: string;
  candidate_id: string;
  referral_id: string | null;
  direction: EmailDirection;
  email_type: EmailType;
  subject: string | null;
  sent_at: string;
  notes: string | null;
  created_by: string | null;
  created_at: string;
}

export interface BonusRule {
  id: string;
  platform_id: string;
  event: 'hired';
  hours_requirement: number;
  amount: number;
  currency: string;
  one_time_per_candidate: boolean;
  effective_from: string;
  effective_to: string | null;
  active: boolean;
  created_at: string;
  updated_at: string;
}

export interface BonusRecord {
  id: string;
  referral_id: string;
  bonus_rule_id: string;
  candidate_id: string;
  one_time_per_candidate: boolean;
  amount: number;
  currency: string;
  status: BonusStatus;
  earned_at: string | null;
  paid_at: string | null;
  exchange_rate_used: number | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

// One row per referral, joined with candidate/platform/account/job/bonus -
// mirrors public.vw_referral_dashboard exactly so the UI and MCP server never
// disagree on what a field means.
export interface ReferralDashboardRow {
  referral_id: string;
  status: ReferralStatus;
  referral_date: string;
  applied_at: string | null;
  hired_at: string | null;
  not_hired_at: string | null;
  hours_completed: number;
  candidate_id: string;
  first_name: string;
  last_name: string;
  candidate_email: string | null;
  platform_id: string;
  platform_name: string;
  platform_slug: string;
  account_id: string;
  account_name: string;
  job_id: string;
  job_title: string;
  bonus_record_id: string | null;
  bonus_amount: number | null;
  bonus_currency: string | null;
  bonus_status: BonusStatus | null;
  email_count: number;
}

export interface DashboardFilters {
  platformId?: string;
  accountId?: string;
  dateFrom?: string;
  dateTo?: string;
}

export interface DashboardSummary {
  accounts: number;
  referrals: number;
  applied: number;
  hired: number;
  notHired: number;
  emailed: number;
  referralToHireRate: number;
  bonusExpected: number;
  bonusRemaining: number;
  bonusPaid: number;
  bonusDisputed: number;
}
