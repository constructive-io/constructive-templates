-- Deploy: schemas/myapp_auth_private/procedures/mint_org_credential/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_private.mint_org_credential(
  IN session_id uuid,
  IN credential_id uuid,
  IN org_id uuid,
  IN principal_id uuid,
  IN secret_hash bytea,
  IN mfa_level text,
  IN access_level text,
  IN expires_at timestamptz,
  IN key_name text,
  IN actor_id uuid
) RETURNS void AS $_PGFN_$
BEGIN
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    origin,
    expires_at
  )
  VALUES
    (mint_org_credential.session_id, mint_org_credential.org_id, false, NULL, mint_org_credential.expires_at);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    mfa_level,
    access_level,
    expires_at,
    name,
    principal_id,
    org_id
  )
  VALUES
    (mint_org_credential.credential_id, mint_org_credential.session_id, 'api_key', mint_org_credential.secret_hash, mint_org_credential.mfa_level, mint_org_credential.access_level, mint_org_credential.expires_at, mint_org_credential.key_name, mint_org_credential.principal_id, mint_org_credential.org_id);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (mint_org_credential.actor_id, 'create_org_api_key', true);
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

