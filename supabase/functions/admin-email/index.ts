// Supabase Database Webhook -> Edge Function -> Resend.
// Deploy with JWT verification disabled, but ALWAYS set WEBHOOK_SECRET.
import { createClient } from 'npm:@supabase/supabase-js@2';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return new Response('Method not allowed', { status: 405 });
  const expected = Deno.env.get('WEBHOOK_SECRET');
  if (!expected || req.headers.get('x-webhook-secret') !== expected) return new Response('Unauthorized', { status: 401 });
  const resendKey = Deno.env.get('RESEND_API_KEY');
  const from = Deno.env.get('EMAIL_FROM');
  const to = Deno.env.get('ADMIN_EMAIL');
  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
  if (![resendKey, from, to, supabaseUrl, serviceKey].every(Boolean)) return new Response('Missing configuration', { status: 500 });
  let payload: { type?: string; table?: string; record?: { id?: string; user_id?: string; title?: string; message?: string; created_at?: string } };
  try { payload = await req.json(); } catch { return new Response('Invalid JSON', { status: 400 }); }
  if (payload.type !== 'INSERT' || payload.table !== 'notifications' || !payload.record?.id || !payload.record.user_id) return new Response('Ignored', { status: 200 });
  const db = createClient(supabaseUrl!, serviceKey!, { auth: { persistSession: false } });
  const { data: profile, error } = await db.from('profiles').select('role').eq('id', payload.record.user_id).maybeSingle();
  if (error) return new Response('Could not validate recipient', { status: 500 });
  if (profile?.role !== 'admin') return new Response('Ignored non-admin notification', { status: 200 });
  const safe = (s: string) => s.replace(/[&<>"']/g, c => ({ '&':'&amp;', '<':'&lt;', '>':'&gt;', '"':'&quot;', "'":'&#39;' }[c]!));
  const title = (payload.record.title ?? 'Nova atividade').slice(0, 150);
  const message = (payload.record.message ?? 'Há uma nova atividade na plataforma.').slice(0, 3000);
  const res = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { Authorization: `Bearer ${resendKey}`, 'Content-Type': 'application/json', 'Idempotency-Key': `notification-${payload.record.id}` },
    body: JSON.stringify({ from, to: [to], subject: `[Onde Eu Começo] ${title}`, html: `<h2>${safe(title)}</h2><p>${safe(message)}</p><p>Consulte o painel administrativo para mais detalhes.</p>` }),
  });
  if (!res.ok) { console.error('Resend error', res.status, await res.text()); return new Response('Email provider error', { status: 502 }); }
  return new Response('Email sent', { status: 200 });
});
