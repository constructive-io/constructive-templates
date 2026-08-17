import { NextResponse } from 'next/server';

import { SSO_GATEWAY_URL } from '@/lib/sso/gateway';

/**
 * GET /auth/google/callback — Google's return leg, relayed to the cloud
 * function's page lane.
 *
 * Google's redirect URI is `http://localhost:3000/auth/google/callback`
 * (the registered value); the function's callback lives at
 * `http://localhost/auth/callback` on the gateway. This route bridges the
 * two: the raw query (`code`, `state`, provider errors) is forwarded with
 * `redirect: 'manual'`, and the upstream 302 + every `Set-Cookie` value is
 * relayed verbatim so the browser lands on the app with its session cookie —
 * the session token never touches client JavaScript.
 */
export async function GET(req: Request): Promise<NextResponse> {
  const query = new URL(req.url).search;
  const upstream = await fetch(`${SSO_GATEWAY_URL}/auth/callback${query}`, {
    method: 'GET',
    redirect: 'manual',
    cache: 'no-store',
  });

  const headers = new Headers();
  const location = upstream.headers.get('location');
  if (location) headers.set('location', location);
  const contentType = upstream.headers.get('content-type');
  if (contentType) headers.set('content-type', contentType);
  for (const cookie of upstream.headers.getSetCookie()) {
    headers.append('set-cookie', cookie);
  }

  const body = upstream.status === 302 ? null : Buffer.from(await upstream.arrayBuffer());
  return new NextResponse(body, { status: upstream.status, headers });
}
