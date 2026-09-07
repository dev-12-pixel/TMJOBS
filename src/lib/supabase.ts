import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

// Untyped on purpose: hand-rolling a Database generic against supabase-js's
// current (deeply generic) query-builder types is high-effort/low-value here.
// Query results are typed at the call site via the domain interfaces in
// './types' instead (e.g. `const rows: Candidate[] = data ?? []`).
export const supabase = createClient(supabaseUrl, supabaseAnonKey);
