/**
 * modules.ts — Provision module presets for the constructive-app.
 *
 * Source of truth: the upstream module presets in constructive-db
 * (packages/node-type-registry/src/module-presets/). AUTH_HARDENED_MODULES
 * mirrors the `auth:hardened` preset verbatim; ORG_MODULES is the delta that
 * `b2b:storage` layers on top for the B2B opt-in path (see docs/B2B.md).
 *
 * IMPORTANT — module shape:
 *   - Unscoped modules are plain strings:        'users_module'
 *   - Scoped modules MUST use tuple form:        ['permissions_module', { scope: 'app' }]
 *
 *   The live `databaseProvisionModule` proc REJECTS the legacy colon-string form
 *   ('permissions_module:app') with a PROVISION-001 hard-fail. The generated SDK
 *   types `modules` as `string[]` because the underlying column is JSONB; pass
 *   `asModules(...)` at the call site to satisfy the SDK boundary.
 */

export type ModuleScope = { scope: 'app' | 'org' };
export type ProvisionModule = string | [string, ModuleScope];

/**
 * BASE tier — the upstream `auth:hardened` preset.
 *
 * Email/password auth with rate limiting, SSO, passkeys, SMS, and magic-link /
 * OTP infrastructure installed. Single-tenant (no orgs / teams / invites /
 * permissions at org scope). For multi-tenant B2B, layer on ORG_MODULES.
 *
 * Mirrors constructive-db/packages/node-type-registry/src/module-presets/auth-hardened.ts
 * verbatim. Note: `internal_secrets_module` replaces the removed
 * `config_secrets_module` from the old auth:email set.
 */
export const AUTH_HARDENED_MODULES: ProvisionModule[] = [
  'users_module',
  'membership_types_module',
  ['permissions_module', { scope: 'app' }],
  ['limits_module', { scope: 'app' }],
  ['levels_module', { scope: 'app' }],
  ['memberships_module', { scope: 'app' }],
  'sessions_module',
  'user_state_module',
  'user_credentials_module',
  ['internal_secrets_module', { scope: 'app' }],
  'emails_module',
  'rls_module',
  'user_auth_module',
  'session_secrets_module',
  'rate_limits_module',
  'connected_accounts_module',
  ['identity_providers_module', { scope: 'app' }],
  'webauthn_credentials_module',
  'webauthn_auth_module',
  'phone_numbers_module',
  'devices_module'
];

/**
 * B2B OPT-IN — the org modules layered on top of {@link AUTH_HARDENED_MODULES}.
 *
 * An app that adopts the registry org blocks (org-create-card,
 * org-members-list, org-roles-editor, org-settings-form) provisions these in
 * addition to the base set. This is the delta between the upstream
 * `b2b:storage` preset and `auth:hardened` (see docs/B2B.md).
 */
export const ORG_MODULES: ProvisionModule[] = [
  ['permissions_module', { scope: 'org' }],
  ['limits_module', { scope: 'org' }],
  ['levels_module', { scope: 'org' }],
  ['memberships_module', { scope: 'org' }],
  ['profiles_module', { scope: 'app' }],
  ['profiles_module', { scope: 'org' }],
  ['hierarchy_module', { scope: 'org' }],
  ['invites_module', { scope: 'app' }],
  ['invites_module', { scope: 'org' }],
  ['storage_module', { scope: 'app' }]
];

/**
 * Cast a typed module preset to the `string[]` shape the generated SDK expects.
 * The server accepts the JSONB tuple form at runtime; this only bridges the
 * narrow generated TypeScript signature.
 */
export function asModules(modules: ProvisionModule[]): string[] {
  return modules as unknown as string[];
}
