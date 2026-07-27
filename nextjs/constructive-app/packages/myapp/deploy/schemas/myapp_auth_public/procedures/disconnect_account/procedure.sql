-- Deploy: schemas/myapp_auth_public/procedures/disconnect_account/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_store_private/tables/user_secrets/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


CREATE FUNCTION myapp_auth_public.disconnect_account(
  IN account_id uuid
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_has_password boolean;
  v_other_accounts_count int;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'NOT_AUTHENTICATED';
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND ((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)))) THEN
    RAISE EXCEPTION 'STEP_UP_REQUIRED';
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_store_private.user_secrets
    WHERE
      owner_id = v_user_id AND name = 'password_hash') INTO v_has_password;
  SELECT count(*)
  FROM myapp_user_identifiers_private.connected_accounts
  WHERE
    owner_id = v_user_id AND id <> disconnect_account.account_id INTO v_other_accounts_count;
  IF NOT (v_has_password) AND v_other_accounts_count = 0 THEN
    RAISE EXCEPTION 'CANNOT_DISCONNECT_LAST_AUTH_METHOD';
  END IF;
  DELETE FROM myapp_user_identifiers_private.connected_accounts
  WHERE
    id = disconnect_account.account_id AND owner_id = v_user_id;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'CONNECTED_ACCOUNT_NOT_FOUND';
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'disconnect_account', true);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

