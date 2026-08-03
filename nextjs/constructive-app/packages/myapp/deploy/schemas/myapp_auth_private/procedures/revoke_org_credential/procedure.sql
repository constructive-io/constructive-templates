-- Deploy: schemas/myapp_auth_private/procedures/revoke_org_credential/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_private.revoke_org_credential(
  IN key_id uuid,
  IN session_id uuid,
  IN actor_id uuid
) RETURNS void AS $_PGFN_$
BEGIN
  DELETE FROM myapp_auth_private.session_credentials
  WHERE
    id = revoke_org_credential.key_id;
  DELETE FROM myapp_auth_private.sessions
  WHERE
    id = revoke_org_credential.session_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (revoke_org_credential.actor_id, 'revoke_org_api_key', true);
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

