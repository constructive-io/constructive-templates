-- Deploy: schemas/myapp_auth_public/procedures/enable_totp/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/auth_rate_limits/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE FUNCTION myapp_auth_public.enable_totp(
  OUT totp_secret text
) RETURNS text AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_totp_secret text;
  v_security_settings myapp_users_public.user_settings_security;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
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
  PERFORM pg_advisory_xact_lock(hashtext('enable_totp'), hashtext(v_user_id::text));
  SELECT *
  FROM myapp_users_public.user_settings_security AS uss
  WHERE
    uss.owner_id = v_user_id INTO v_security_settings;
  IF v_security_settings.totp_enabled IS TRUE THEN
    PERFORM errors.raise_error('TOTP_ALREADY_ENABLED', '{}', 'public');
  END IF;
  v_totp_secret := totp.random_base32(20);
  PERFORM myapp_store_private.user_state_set(v_user_id, 'totp_setup_secret', v_totp_secret);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'enable_totp_initiated', true);
  SELECT v_totp_secret INTO totp_secret;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

