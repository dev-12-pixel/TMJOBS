import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Database = {
  public: {
    Tables: {
      users: {
        Row: {
          id: string;
          email: string;
          full_name: string | null;
          avatar_url: string | null;
          referral_code: string | null;
          role: string;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          email: string;
          full_name?: string | null;
          avatar_url?: string | null;
          referral_code?: string | null;
          role?: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          email?: string;
          full_name?: string | null;
          avatar_url?: string | null;
          referral_code?: string | null;
          role?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      clients: {
        Row: {
          id: string;
          name: string;
          logo_url: string | null;
          description: string | null;
          website_url: string | null;
          created_by: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          logo_url?: string | null;
          description?: string | null;
          website_url?: string | null;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          logo_url?: string | null;
          description?: string | null;
          website_url?: string | null;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      job_profiles: {
        Row: {
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
        };
        Insert: {
          id?: string;
          client_id: string;
          title: string;
          description?: string | null;
          location?: string | null;
          salary_range?: string | null;
          referral_bonus_amount?: number;
          status?: string;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          client_id?: string;
          title?: string;
          description?: string | null;
          location?: string | null;
          salary_range?: string | null;
          referral_bonus_amount?: number;
          status?: string;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      candidates: {
        Row: {
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
        };
        Insert: {
          id?: string;
          job_profile_id: string;
          first_name: string;
          last_name: string;
          email: string;
          phone?: string | null;
          linkedin_url?: string | null;
          resume_url?: string | null;
          notes?: string | null;
          source?: string | null;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          job_profile_id?: string;
          first_name?: string;
          last_name?: string;
          email?: string;
          phone?: string | null;
          linkedin_url?: string | null;
          resume_url?: string | null;
          notes?: string | null;
          source?: string | null;
          created_by?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      referrals: {
        Row: {
          id: string;
          candidate_id: string;
          referrer_id: string;
          job_profile_id: string;
          status: string;
          applied_at: string;
          signed_up_at: string | null;
          hired_at: string | null;
          not_hired_at: string | null;
          hired_by: string | null;
          notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          candidate_id: string;
          referrer_id: string;
          job_profile_id: string;
          status?: string;
          applied_at?: string;
          signed_up_at?: string | null;
          hired_at?: string | null;
          not_hired_at?: string | null;
          hired_by?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          candidate_id?: string;
          referrer_id?: string;
          job_profile_id?: string;
          status?: string;
          applied_at?: string;
          signed_up_at?: string | null;
          hired_at?: string | null;
          not_hired_at?: string | null;
          hired_by?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      tracking_events: {
        Row: {
          id: string;
          referral_id: string;
          event_type: string;
          event_date: string;
          metadata: Record<string, unknown> | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          referral_id: string;
          event_type: string;
          event_date?: string;
          metadata?: Record<string, unknown> | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          referral_id?: string;
          event_type?: string;
          event_date?: string;
          metadata?: Record<string, unknown> | null;
          created_at?: string;
        };
      };
      payments: {
        Row: {
          id: string;
          referral_id: string;
          candidate_id: string;
          job_profile_id: string;
          client_id: string;
          referrer_id: string;
          amount: number;
          currency: string;
          status: string;
          paid_at: string | null;
          payment_method: string | null;
          invoice_number: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          referral_id: string;
          candidate_id: string;
          job_profile_id: string;
          client_id: string;
          referrer_id: string;
          amount: number;
          currency?: string;
          status?: string;
          paid_at?: string | null;
          payment_method?: string | null;
          invoice_number?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          referral_id?: string;
          candidate_id?: string;
          job_profile_id?: string;
          client_id?: string;
          referrer_id?: string;
          amount?: number;
          currency?: string;
          status?: string;
          paid_at?: string | null;
          payment_method?: string | null;
          invoice_number?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
    };
  };
};
