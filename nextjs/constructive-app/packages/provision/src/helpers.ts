/**
 * helpers.ts — Shared utilities for constructive-app provisioning
 *
 * Uses @constructive-io/node for auth/public_ SDK clients and @constructive-io/fetch for HTTP.
 */

import { auth, public_, admin, NodeHttpAdapter } from '@constructive-io/node';
import { createFetch } from '@constructive-io/fetch';

import { config } from './config.js';

/**
 * Retry helper for transient failures during provisioning.
 * Immediately rethrows "already exists" errors (idempotency).
 */
export async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries = 5,
  delayMs = 2000
): Promise<T> {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fn();
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes('already exists') || msg.includes('ACCOUNT_EXISTS') || msg.includes('duplicate key') || msg.includes('unique constraint')) throw err;
      if (attempt === maxRetries) throw err;
      console.log(
        `   Attempt ${attempt}/${maxRetries} failed: ${msg.slice(0, 120)}. Retrying in ${delayMs}ms...`
      );
      await new Promise((r) => setTimeout(r, delayMs));
    }
  }
  throw new Error('unreachable');
}

/**
 * Create a platform API client using the upstream Constructive SDK.
 * Points at the app-specific endpoint (api-{dbName}.localhost).
 *
 * Uses @constructive-io/sdk (via @constructive-io/node) instead of an
 * app-specific generated SDK because provision runs BEFORE codegen, so the
 * app-specific SDK doesn't exist yet. The upstream SDK has all the
 * platform types (database, schema, table, field, etc.) needed for
 * provisioning. App-specific models are NOT needed during provision —
 * seed data uses rawExecute or direct SQL.
 *
 * @param accessToken Optional user JWT — if omitted falls back to
 *   config.accessToken (the provision token from .env).
 */
export function createPlatformClient(accessToken?: string): ReturnType<typeof public_.createClient> {
  const token = accessToken ?? config.accessToken;
  if (!token) throw new Error('ACCESS_TOKEN is required');

  const headers: Record<string, string> = {
    Authorization: `Bearer ${token}`,
  };
  return public_.createClient({
    adapter: new NodeHttpAdapter(config.appEndpoint, headers),
  });
}

/**
 * Create an admin API client using the upstream Constructive SDK.
 * Points at admin-{dbName}.localhost which exposes the full admin
 * schema including appMembership, appPermission, etc.
 *
 * Uses @constructive-io/sdk (via @constructive-io/node) instead of an
 * app-specific generated SDK because provision runs BEFORE codegen.
 *
 * @param accessToken A db-scoped user JWT (required).
 */
export function createAdminSdkClient(accessToken: string): ReturnType<typeof admin.createClient> {
  const headers: Record<string, string> = {
    Authorization: `Bearer ${accessToken}`,
  };
  return admin.createClient({
    adapter: new NodeHttpAdapter(config.adminEndpoint, headers),
  });
}

/**
 * Execute a raw GraphQL mutation against a given endpoint.
 * Uses @constructive-io/fetch for *.localhost DNS handling.
 */
export async function rawExecute<T = unknown>(
  endpoint: string,
  headers: Record<string, string>,
  mutation: string,
  variables: Record<string, unknown> = {}
): Promise<{ ok: boolean; data: T | null; errors?: Array<{ message: string }> }> {
  const fetchFn = createFetch();
  const response = await fetchFn(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Accept: 'application/json',
      ...headers,
    },
    body: JSON.stringify({ query: mutation, variables }),
  });

  if (!response.ok) {
    let detail = '';
    try {
      const body = await response.text();
      if (body) detail = ` — ${body.slice(0, 500)}`;
    } catch { /* ignore */ }
    return {
      ok: false,
      data: null,
      errors: [{ message: `HTTP ${response.status}: ${response.statusText}${detail}` }],
    };
  }

  const json = (await response.json()) as {
    data?: T;
    errors?: Array<{ message: string }>;
  };

  if (json.errors && json.errors.length > 0) {
    return { ok: false, data: null, errors: json.errors };
  }

  return { ok: true, data: json.data as T };
}

/**
 * Execute a raw GraphQL mutation against the admin endpoint.
 * Use this for mutations not yet in the generated admin SDK
 * (e.g. provisionNewUser).
 *
 * @param accessToken A db-scoped user JWT.
 * @param mutation The GraphQL mutation string.
 * @param variables The mutation variables.
 * @returns The raw data result.
 */
export async function executeAdminMutation<T = unknown>(
  accessToken: string,
  mutation: string,
  variables: Record<string, unknown> = {}
): Promise<T> {
  const result = await rawExecute<T>(config.adminEndpoint, {
    Authorization: `Bearer ${accessToken}`,
  }, mutation, variables);
  if (!result.ok) {
    const msgs = result.errors?.map((e: { message: string }) => e.message).join('; ') ?? 'Unknown error';
    throw new Error(`Admin mutation failed: ${msgs}`);
  }
  return result.data as T;
}

/**
 * Execute a raw GraphQL mutation against the db-scoped auth endpoint.
 * Use this for mutations like createUser (which has type field for
 * creating org users) that aren't on the admin endpoint.
 *
 * @param accessToken A db-scoped user JWT.
 * @param mutation The GraphQL mutation string.
 * @param variables The mutation variables.
 * @returns The raw data result.
 */
export async function executeAuthMutation<T = unknown>(
  accessToken: string,
  mutation: string,
  variables: Record<string, unknown> = {}
): Promise<T> {
  const result = await rawExecute<T>(config.dbAuthEndpoint, {
    Authorization: `Bearer ${accessToken}`,
  }, mutation, variables);
  if (!result.ok) {
    const msgs = result.errors?.map((e: { message: string }) => e.message).join('; ') ?? 'Unknown error';
    throw new Error(`Auth mutation failed: ${msgs}`);
  }
  return result.data as T;
}

/**
 * Execute a raw GraphQL mutation against the app endpoint.
 * Use this for mutations that live on the app endpoint.
 *
 * @param accessToken A db-scoped user JWT.
 * @param mutation The GraphQL mutation string.
 * @param variables The mutation variables.
 * @returns The raw data result.
 */
export async function executeAppMutation<T = unknown>(
  accessToken: string,
  mutation: string,
  variables: Record<string, unknown> = {}
): Promise<T> {
  const result = await rawExecute<T>(config.appEndpoint, {
    Authorization: `Bearer ${accessToken}`,
  }, mutation, variables);
  if (!result.ok) {
    const msgs = result.errors?.map((e: { message: string }) => e.message).join('; ') ?? 'Unknown error';
    throw new Error(`App mutation failed: ${msgs}`);
  }
  return result.data as T;
}

/**
 * Create a metaschema client pointing at the "api" endpoint.
 * This endpoint exposes structural/platform types: database, schema, api,
 * apiSchema, domain, field, table, policy, index, function, enum, etc.
 * For provisioning types (blueprint, constructBlueprint,
 * databaseProvisionModule, etc.) use the "modules" endpoint via
 * public_.createClient({ adapter: new NodeHttpAdapter(config.modulesEndpoint, ...) }).
 */
export function createMetaschemaClient(): ReturnType<typeof public_.createClient> {
  const token = config.accessToken;
  if (!token) throw new Error('ACCESS_TOKEN is required');

  const headers: Record<string, string> = {
    Authorization: `Bearer ${token}`,
    'X-Meta-Schema': 'true'
  };
  if (config.databaseId) {
    headers['X-Database-Id'] = config.databaseId;
  }
  return public_.createClient({
    adapter: new NodeHttpAdapter(config.apiEndpoint, headers),
  });
}

/**
 * Create an auth client for sign-up / sign-in via the GLOBAL
 * metaschema auth endpoint (auth.localhost). Tokens from this
 * endpoint are NOT valid for database-scoped endpoints.
 * Only used by create-db.ts for the initial admin user.
 */
export function createAuthClient(): ReturnType<typeof auth.createClient> {
  return auth.createClient({
    adapter: new NodeHttpAdapter(config.authEndpoint, {
      'X-Meta-Schema': 'true',
      'X-Schemata': 'constructive_auth_public',
    }),
  });
}

/**
 * Create an auth client for sign-up / sign-in via the DATABASE-SCOPED
 * auth endpoint (auth-{dbName}.localhost). Tokens from this endpoint
 * ARE valid for the app and admin endpoints of the same database.
 * This is the correct client for seed scripts to use.
 */
export function createDbAuthClient(): ReturnType<typeof auth.createClient> {
  return auth.createClient({
    adapter: new NodeHttpAdapter(config.dbAuthEndpoint),
  });
}

/**
 * Get the database ID from config, throwing if missing.
 */
export function requireDatabaseId(): string {
  const id = config.databaseId;
  if (!id) {
    console.error('Missing DATABASE_ID. Run create-db first.');
    process.exit(1);
  }
  return id;
}

/**
 * Resolve the app_public schema ID for a given database via direct SQL.
 * This is needed because constructBlueprint requires a schemaId parameter.
 */
export async function resolveAppPublicSchemaId(
  databaseId: string,
  pgDatabase: string
): Promise<string> {
  const { Pool } = await import('pg');
  const pool = new Pool({ database: pgDatabase });
  try {
    const result = await pool.query(
      `SELECT id FROM metaschema_public.schema WHERE database_id = $1 AND name = 'app_public' LIMIT 1`,
      [databaseId]
    );
    if (result.rows.length === 0) {
      throw new Error(`No app_public schema found for database ${databaseId}`);
    }
    return result.rows[0].id;
  } finally {
    await pool.end();
  }
}

/**
 * Get the app_public schema ID from the environment (set by provision.ts).
 */
export function requireSchemaId(): string {
  const id = process.env.APP_PUBLIC_SCHEMA_ID;
  if (!id) {
    throw new Error('APP_PUBLIC_SCHEMA_ID not set. This should be resolved by provision.ts before calling schema modules.');
  }
  return id;
}

// Re-export the client types for convenience
export type PlatformClient = ReturnType<typeof createPlatformClient>;
export type MetaschemaClient = ReturnType<typeof createMetaschemaClient>;
