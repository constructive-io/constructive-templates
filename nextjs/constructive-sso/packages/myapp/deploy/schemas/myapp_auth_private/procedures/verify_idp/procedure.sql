-- Deploy: schemas/myapp_auth_private/procedures/verify_idp/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


CREATE FUNCTION myapp_auth_private.verify_idp(
  IN service text,
  IN identifier text,
  IN details jsonb DEFAULT NULL
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_account_linked boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_private.connected_accounts AS ca
    WHERE
      (ca.service = verify_idp.service AND ca.identifier = verify_idp.identifier) AND ca.owner_id = v_user_id) INTO v_account_linked;
  IF NOT (v_account_linked IS TRUE) THEN
    PERFORM errors.raise_error('IDENTITY_ACCOUNT_NOT_FOUND', '{}', 'public');
  END IF;
  UPDATE myapp_auth_private.sessions AS sess SET
  last_idp_verified = CURRENT_TIMESTAMP, last_mfa_verified = CASE 
    WHEN COALESCE((verify_idp.details->>'mfa_verified')::boolean, false) THEN CURRENT_TIMESTAMP 
    ELSE last_mfa_verified 
  END, expires_at = expires_at + '30 minutes'::interval
  WHERE
    sess.id = v_session_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'verify_idp', true);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

