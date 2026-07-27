-- Deploy: migrate/table
-- made with <3 @ constructive.io

-- requires: migrate/schema_grant


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO metaschema_public.table (
  id,
  database_id,
  schema_id,
  name,
  label,
  description,
  smart_tags,
  category,
  use_rls,
  timestamps,
  peoplestamps,
  plural_name,
  singular_name,
  tags,
  step_up,
  partitioned,
  partition_strategy,
  partition_key_names,
  partition_key_types,
  inherits_id
) VALUES
  ('019fa2a1-5022-77c8-9de2-2ef6079855de', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'users', NULL, NULL, NULL, 'app', true, true, false, 'users', 'user', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5065-75d9-bf4c-86d761848b2b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'role_types', NULL, NULL, NULL, 'module', false, false, false, 'role_types', 'role_type', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-50bf-7eba-a17a-9839835e08f4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'membership_types', NULL, 'Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member)', NULL, 'memberships', true, false, false, 'membership_types', 'membership_type', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5131-7642-b999-a3637fd3f1a5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'app_permissions', NULL, 'Defines available permissions as named bits within a bitmask, used by the RBAC system for access control', NULL, 'core', true, false, false, 'app_permissions', 'app_permission', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5182-755b-a123-1190a88df2cf', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'app_permission_defaults', NULL, 'Stores the default permission bitmask assigned to new members upon joining', NULL, 'core', true, false, false, 'app_permission_defaults', 'app_permission_default', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-51d7-7525-a82f-f18b7765f445', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limits', NULL, 'Tracks per-actor usage counts against configurable maximum limits', NULL, 'core', true, false, false, 'app_limits', 'app_limit', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5245-7943-99d6-ab69b0046c4a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_defaults', NULL, 'Default maximum values for each named limit, applied when no per-actor override exists', NULL, 'core', true, false, false, 'app_limit_defaults', 'app_limit_default', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5285-725c-9bcd-65d477e277f4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_credits', NULL, 'Append-only ledger of credit grants that automatically update limit ceilings', NULL, 'core', true, false, false, 'app_limit_credits', 'app_limit_credit', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_events', NULL, 'Append-only log of limit events for historical reporting and audit', NULL, 'core', true, false, false, 'app_limit_events', 'app_limit_event', '{}', NULL, true, 'range', '{created_at}', '{timestamptz}', NULL),
  ('019fa2a1-5378-7160-b636-5d7814a54a7c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_credit_codes', NULL, 'Redeemable credit codes managed by admins with the add_credits permission', NULL, 'core', true, false, false, 'app_limit_credit_codes', 'app_limit_credit_code', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-53be-7020-a577-17e52f91740f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_credit_code_items', NULL, 'Items within a credit code — each row grants credits for a specific limit definition', NULL, 'core', true, false, false, 'app_limit_credit_code_items', 'app_limit_credit_code_item', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5416-73f2-acac-2d0393ddb8cb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_credit_redemptions', NULL, 'Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits', NULL, 'core', true, false, false, 'app_limit_credit_redemptions', 'app_limit_credit_redemption', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5468-7986-ba62-d5ec673318b9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_caps_defaults', NULL, 'Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers.', NULL, 'core', true, false, false, 'app_limit_caps_defaults', 'app_limit_caps_default', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5496-7d14-aea2-866a78236d8a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_caps', NULL, 'Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default.', NULL, 'core', true, false, false, 'app_limit_caps', 'app_limit_cap', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-54d8-72b7-8837-7d5008546c02', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'app_limit_warnings', NULL, 'Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it.', NULL, 'module', false, false, false, 'app_limit_warnings', 'app_limit_warning', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5515-74cb-b03a-e1a7265372b4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'app_limit_warning_state', NULL, 'Tracks which warnings have been sent to avoid duplicate notifications. One row per warning config per actor.', NULL, 'module', false, false, false, 'app_limit_warning_states', 'app_limit_warning_state', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_memberships', NULL, 'Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status', NULL, 'memberships', true, true, true, 'app_memberships', 'app_membership', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-55cd-7a92-9979-3b8d9bc899b3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_membership_defaults', NULL, 'Default membership settings per entity, controlling initial approval and verification state for new members', NULL, 'memberships', true, true, true, 'app_membership_defaults', 'app_membership_default', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5607-704a-bacc-b1c2d99357f7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'app_memberships_sprt', NULL, 'Security Predicate Resolution Table (SPRT). Denormalized lookup table used by RLS policies for fast permission checks without recursive queries', NULL, 'permissions', false, false, false, 'app_memberships_sprts', 'app_memberships_sprt', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-56f9-78f0-931f-4812580b70dd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_admin_grants', NULL, 'Records of admin role grants and revocations between members', NULL, 'permissions', true, true, false, 'app_admin_grants', 'app_admin_grant', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_owner_grants', NULL, 'Records of ownership transfers and grants between members', NULL, 'permissions', true, true, false, 'app_owner_grants', 'app_owner_grant', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-57ac-73c9-bd3e-65e6d7444548', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_grants', NULL, 'Records of individual permission grants and revocations for members via bitmask', NULL, 'permissions', true, true, false, 'app_grants', 'app_grant', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_permission_default_permissions', NULL, 'Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask', NULL, 'permissions', true, true, false, 'app_permission_default_permissions', 'app_permission_default_permission', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5856-7452-ad3a-45b1f4c4fc67', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'app_permission_default_grants', NULL, 'Audit log of permission additions and removals from the defaults bitmask', NULL, 'permissions', true, true, false, 'app_permission_default_grants', 'app_permission_default_grant', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5b1d-7b27-bab2-e3c469e536af', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'user_state', NULL, 'Internal per-user state store for auth counters, tokens, and ephemeral data', NULL, 'module', true, false, false, 'user_states', 'user_state', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'sessions', NULL, 'Tracks user authentication sessions with expiration, fingerprinting, and step-up verification state', NULL, 'auth', false, true, false, 'sessions', 'session', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'session_credentials', NULL, 'Authentication credentials (bearer tokens, cookies, API keys, magic links) tied to sessions', NULL, 'auth', false, true, false, 'session_credentials', 'session_credential', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-5d87-7ece-8e60-1ad949ecfb19', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'app_settings_auth', NULL, 'Singleton configuration table for authentication settings including session durations, lockout policy, and password requirements', NULL, 'auth', true, true, false, 'app_settings_auths', 'app_settings_auth', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-613c-724f-87a1-acb6049c0b8b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'session_secrets', NULL, 'DB-private, session-scoped ephemeral key-value store for challenges/nonces (e.g. WebAuthn challenges, MFA tokens, magic-link nonces). Never exposed to clients; accessed only by SECURITY DEFINER procedures on the private schema.', NULL, 'auth', true, true, false, 'session_secrets', 'session_secret', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-61d6-7dff-876e-13802d91c7ec', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'app_settings_rate_limit', NULL, 'Singleton configuration table for rate limiting thresholds including IP-based and user-based windows, attempt limits, and lockout durations', NULL, 'auth', true, true, false, 'app_settings_rate_limits', 'app_settings_rate_limit', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-62f0-7b99-aea9-87eac6e5fe19', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'auth_ip_rate_limits', NULL, 'Tracks per-IP-address rate limiting state for anonymous auth functions with native inet type support and /64 IPv6 normalization', NULL, 'auth', false, true, false, 'auth_ip_rate_limits', 'auth_ip_rate_limit', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-639b-7ad6-b70a-a9e79a494ed0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'auth_rate_limits', NULL, 'Tracks per-user/subject rate limiting state for auth functions using UUID subject identifiers', NULL, 'auth', false, true, false, 'auth_rate_limits', 'auth_rate_limit', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-643a-7595-bd9e-8c50e40166bc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'app_settings_device', NULL, 'Singleton configuration table for device tracking and trust settings', NULL, 'core', true, true, false, 'app_settings_devices', 'app_settings_device', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6514-72da-b9d9-3bdb2c772b8c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'auth_user_devices', NULL, 'Tracks recognized and trusted devices per user via persistent opaque device tokens', NULL, 'core', true, true, false, 'auth_user_devices', 'auth_user_device', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6661-7502-b1a4-7ebfccb37ee9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'user_secrets', NULL, 'Per-user bcrypt credential store (password hashes, API key hashes)', NULL, 'module', true, true, false, 'user_secrets', 'user_secret', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-674f-73fa-9633-39edfbd13c6c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'app_internal_secrets', NULL, 'app-level PGP-encrypted key-value secrets store', NULL, 'module', true, true, false, 'app_internal_secrets', 'app_internal_secret', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-69aa-7ba6-a7ef-3303f246936b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'emails', NULL, 'User email addresses with verification and primary-email management', NULL, 'module', true, true, false, 'emails', 'email', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'phone_numbers', NULL, 'User phone numbers with country code, verification, and primary-number management', NULL, 'module', true, true, false, 'phone_numbers', 'phone_number', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'webauthn_credentials', NULL, 'WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn''s canonical Passkey object.', NULL, 'module', true, true, false, 'webauthn_credentials', 'webauthn_credential', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6d06-750a-9c65-845342800227', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'connected_accounts', NULL, 'OAuth and social login connections linking external service accounts to users', NULL, 'module', true, true, false, 'connected_accounts', 'connected_account', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-6e03-77a5-8d95-46056bdd7ccf', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'identity_providers', NULL, 'OAuth2 / OIDC (and future SAML) identity provider definitions per database. Holds endpoint URLs, encrypted client secret reference, scopes, audience validation list, PKCE setting, and email-handling flags. Cached OIDC discovery_doc + JWKS are refreshed by background jobs. All writes go through SECURITY DEFINER admin procedures.', NULL, 'auth', true, true, false, 'identity_providers', 'identity_provider', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-703c-73a4-bcd4-ef0ed194b005', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'audit_log_auth', NULL, 'Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.)', NULL, 'module', true, false, false, 'audit_log_auths', 'audit_log_auth', '{}', NULL, true, 'range', '{created_at}', '{timestamptz}', NULL),
  ('019fa2a1-72e9-73af-9d7e-46dedcbda5ad', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'principals', NULL, 'Scoped sub-identities (API keys and agents) with precomputed SPRT', '{"behavior":"-insert -update -delete"}', 'auth', true, true, false, 'principals', 'principal', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-73db-7463-ae1b-141b8847e6ed', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'principal_entities', NULL, 'Association table scoping principals to specific organizations', NULL, 'auth', true, true, false, 'principal_entities', 'principal_entity', '{}', NULL, false, NULL, '{}', '{}', NULL),
  ('019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'principal_scope_overrides', NULL, 'Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions.', '{"behavior":"-insert -update -delete"}', 'auth', true, true, false, 'principal_scope_overrides', 'principal_scope_override', '{}', NULL, false, NULL, '{}', '{}', NULL);


SET session_replication_role TO DEFAULT;


