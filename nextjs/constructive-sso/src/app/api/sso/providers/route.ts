import { NextResponse } from 'next/server';

import { gatewayPost, sessionCredential } from '@/lib/sso/gateway';

export interface SsoProvider {
  slug: string;
  displayName: string;
}

/** POST /api/sso/providers — the enabled providers for the login grid. */
export async function POST(): Promise<NextResponse> {
  const session = await sessionCredential();
  const result = await gatewayPost<{ providers: SsoProvider[] }>('/providers', {}, session);
  return NextResponse.json({ providers: result.providers });
}
