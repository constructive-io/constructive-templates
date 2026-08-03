-- Deploy: schemas/myapp_auth_public/procedures/revoke_session/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_public.revoke_session(
  IN session_id uuid
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_current_session uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_current_session := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF revoke_session.session_id = v_current_session THEN
    PERFORM errors.raise_error('CANNOT_REVOKE_CURRENT_SESSION', '{}', 'public');
  END IF;
  DELETE FROM myapp_auth_private.session_credentials
  WHERE
    session_credentials.session_id = revoke_session.session_id;
  DELETE FROM myapp_auth_private.sessions
  WHERE
    id = revoke_session.session_id AND user_id = v_user_id;
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('SESSION_NOT_FOUND', '{}', 'public');
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'revoke_session', true);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

