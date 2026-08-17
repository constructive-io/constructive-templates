import { NextResponse } from 'next/server';

import { gatewayPost, isLocalPath, OAUTH_REDIRECT_URI, sessionCredential } from '@/lib/sso/gateway';

interface StartBody {
  provider?: string;
  returnTo?: string;
}

/**
 * POST /api/sso/start — begin an authorization-code flow.
 *
 * The browser names only the provider and a local post-login path; the
 * redirect URI is constructed server-side and can never be chosen by the
 * caller.
 */
export async function POST(req: Request): Promise<NextResponse> {
  let body: StartBody;
  try {
    body = (await req.json()) as StartBody;
  } catch {
    return NextResponse.json({ error: 'invalid JSON body' }, { status: 400 });
  }

  const provider = body.provider;
  if (!provider) {
    return NextResponse.json({ error: 'provider is required' }, { status: 400 });
  }
  const returnTo = body.returnTo ?? '/auth/callback';
  if (!isLocalPath(returnTo)) {
    return NextResponse.json({ error: 'returnTo must be a local path' }, { status: 400 });
  }

  const session = await sessionCredential();
  const result = await gatewayPost<{ location: string; state: string }>(
    '/start',
    { provider, redirect_uri: OAUTH_REDIRECT_URI, return_to: returnTo },
    session
  );
  return NextResponse.json({ location: result.location, state: result.state });
}
