import { NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Webhook target for the Google Form intake pipeline (Form -> Apps Script
// onFormSubmit trigger -> this route). Runs server-side only, so it's safe
// to use the service-role key here (public submitters aren't authenticated
// app users, and RLS would otherwise reject them).
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const webhookSecret = process.env.FORM_WEBHOOK_SECRET || '';

function splitName(full: string) {
  const parts = full.trim().split(/\s+/);
  if (parts.length === 1) return { first: parts[0], last: '' };
  return { first: parts[0], last: parts.slice(1).join(' ') };
}

export async function POST(request: Request) {
  if (!serviceRoleKey || !webhookSecret) {
    return NextResponse.json({ error: 'Intake webhook is not configured' }, { status: 503 });
  }

  const auth = request.headers.get('authorization');
  if (auth !== `Bearer ${webhookSecret}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  let body: Record<string, unknown>;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Invalid JSON body' }, { status: 400 });
  }

  const name = String(body.name || '').trim();
  const email = String(body.email || '').trim().toLowerCase();
  if (!name || !email) {
    return NextResponse.json({ error: 'name and email are required' }, { status: 400 });
  }

  const { first, last } = splitName(name);
  const supabase = createClient(supabaseUrl, serviceRoleKey);

  const { data: existing } = await supabase.from('candidates').select('id').eq('email', email).maybeSingle();

  const record = {
    first_name: first,
    last_name: last || '(unknown)',
    email,
    intro: body.intro ? String(body.intro) : null,
    primary_skills: body.primary_skills ? String(body.primary_skills) : null,
    secondary_skills: body.secondary_skills ? String(body.secondary_skills) : null,
    resume_url: body.resume_url ? String(body.resume_url) : null,
    source: 'google_form' as const,
  };

  if (existing) {
    const { error } = await supabase.from('candidates').update(record).eq('id', existing.id);
    if (error) return NextResponse.json({ error: error.message }, { status: 500 });
    return NextResponse.json({ status: 'updated', id: existing.id });
  }

  const { data, error } = await supabase.from('candidates').insert(record).select('id').single();
  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ status: 'created', id: data.id });
}
