import { NextResponse } from 'next/server';

import { gatewayPost, sessionCredential } from '@/lib/sso/gateway';

const SESSION_COOKIE = 'constructive_session';

/**
 * POST /api/auth/sign-out — revoke the session at the gateway and expire the
 * cookie with the same path/domain rules it was set with.
 */
export async function POST(): Promise<NextResponse> {
  const session = await sessionCredential();
  const result = await gatewayPost<{ signedOut: boolean }>('/auth/sign-out', {}, session);

  const headers = new Headers();
  headers.append(
    'set-cookie',
    `${SESSION_COOKIE}=; Path=/; HttpOnly; SameSite=Lax; Max-Age=0`
  );
  return NextResponse.json({ signedOut: result.signedOut }, { headers });
}
