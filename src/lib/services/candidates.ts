import { supabase } from '@/lib/supabase';
import type { Candidate } from '@/lib/types';

// Duplicate detection is a warning, not a block: match on email or phone and
// let the user decide to reuse the existing candidate or create a new one.
export async function findPossibleDuplicates(email: string, phone: string): Promise<Candidate[]> {
  const conditions: string[] = [];
  if (email.trim()) conditions.push(`email.eq.${email.trim()}`);
  if (phone.trim()) conditions.push(`phone.eq.${phone.trim()}`);
  if (conditions.length === 0) return [];

  const { data, error } = await supabase.from('candidates').select('*').or(conditions.join(','));
  if (error) throw error;
  return data ?? [];
}
