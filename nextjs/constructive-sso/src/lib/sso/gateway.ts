/**
 * sso/gateway — server-only gateway client for the SSO cloud functions.
 *
 * The browser never talks to the compute sync gateway directly: every call
 * goes through these helpers (a Next.js route handler), which forward the
 * HttpOnly `constructive_session` cookie as `Authorization: Bearer` — the
 * gateway's own cookie name is `token`, so forwarding the cookie alone would
 * authenticate nothing.
 *
 * Server-only: never import from a client component.
 */

import 'server-only';

import { cookies } from 'next/headers';

const SESSION_COOKIE = 'constructive_session';

/** Base URL of the compute sync gateway (Traefik → compute-sync). */
export const SSO_GATEWAY_URL = (process.env.SSO_GATEWAY_URL ?? 'http://localhost').replace(/\/$/, '');

/** The app's own origin — where Google's redirect lands (must be `localhost`). */
export const APP_ORIGIN = process.env.APP_ORIGIN ?? 'http://localhost:3000';

/** The registered Google redirect URI — byte-identical between start and exchange. */
export const OAUTH_REDIRECT_URI = `${APP_ORIGIN}/auth/google/callback`;

/** A local path the callback may send the browser to (`/…`, never `//…` or `/\\…`). */
export function isLocalPath(value: string): boolean {
  return value.startsWith('/') && !value.startsWith('//') && !value.startsWith('/\\') && !value.includes('\\');
}

/** The session credential the request carries, if any (cookie → bearer value). */
export async function sessionCredential(): Promise<string | null> {
  const store = await cookies();
  const value = store.get(SESSION_COOKIE)?.value;
  return value || null;
}

/** POST a JSON body to the gateway and unwrap the `{ok, result}` envelope. */
export async function gatewayPost<T = unknown>(path: string, body: unknown, session: string | null): Promise<T> {
  const res = await fetch(`${SSO_GATEWAY_URL}${path}`, {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      ...(session ? { authorization: `Bearer ${session}` } : {}),
    },
    body: JSON.stringify(body),
    cache: 'no-store',
  });
  const payload = (await res.json()) as { ok: boolean; result?: T; error?: { message?: string } };
  if (!payload.ok) {
    throw new Error(payload.error?.message ?? `gateway ${path} failed with HTTP ${res.status}`);
  }
  return payload.result as T;
}
