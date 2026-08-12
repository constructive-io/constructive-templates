-- Deploy: schemas/myapp_auth_public/procedures/generate_backup_codes/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE FUNCTION myapp_auth_public.generate_backup_codes(
  OUT backup_codes text
) RETURNS text AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_codes text;
  v_i int;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND (((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)) OR s.last_idp_verified > (now() - '30 minutes'::interval)))) THEN
    PERFORM errors.raise_error('STEP_UP_REQUIRED', '{}', 'public');
  END IF;
  v_codes := concat_ws(',', encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'), encode(gen_random_bytes(4), 'hex'));
  PERFORM myapp_store_private.user_state_set(v_user_id, 'backup_codes', v_codes);
  UPDATE myapp_users_public.user_settings_security SET
  backup_codes_count = 10
  WHERE
    owner_id = v_user_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'generate_backup_codes', true);
  SELECT v_codes INTO backup_codes;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

