-- Deploy: schemas/myapp_auth_private/procedures/webauthn_finish_registration/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_secrets/table
-- requires: schemas/myapp_auth_private/tables/auth_rate_limits/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_auth_private/tables/auth_ip_rate_limits/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_auth_private/tables/app_settings_rate_limit/table
-- requires: schemas/myapp_auth_public/procedures/current_ip_address/procedure
-- requires: schemas/myapp_auth_private/procedures/set_session_secret/procedure
-- requires: schemas/myapp_auth_private/procedures/consume_session_secret/procedure
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


CREATE FUNCTION myapp_auth_private.webauthn_finish_registration(
  IN credential_id text,
  IN public_key bytea,
  IN sign_count bigint,
  IN transports text[],
  IN credential_device_type text,
  IN backup_eligible boolean,
  IN backup_state boolean,
  IN webauthn_user_id text,
  IN user_id uuid,
  IN name text DEFAULT NULL
) RETURNS uuid AS $_PGFN_$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_new_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_finish_registration'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_finish_registration') AND locked_until > now()
    LIMIT
    1) THEN
      RAISE EXCEPTION 'TOO_MANY_REQUESTS';
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_up, false)) THEN
    RAISE EXCEPTION 'WEBAUTHN_SIGN_UP_DISABLED';
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('webauthn_finish_registration'), hashtext(webauthn_finish_registration.user_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_finish_registration.user_id AND action = 'webauthn_finish_registration' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    RAISE EXCEPTION 'ACCOUNT_LOCKED_EXCEED_ATTEMPTS';
  END IF;
  v_session_id := jwt_private.current_session_id();
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = v_session_id AND s.name = 'webauthn_register_challenge') AND (s.expires_at IS NULL OR s.expires_at > now())
  RETURNING s.value INTO v_challenge;
  IF v_challenge IS NULL THEN
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (webauthn_finish_registration.user_id, 'webauthn_finish_registration', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.login_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.login_lockout_duration) THEN now() + v_rate_settings.login_lockout_duration 
      ELSE NULL 
    END;
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (webauthn_finish_registration.user_id, 'webauthn_finish_registration_challenge_not_found', false);
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'webauthn_finish_registration', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'webauthn_finish_registration', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RAISE EXCEPTION 'WEBAUTHN_REGISTER_CHALLENGE_NOT_FOUND_OR_EXPIRED';
  END IF;
  INSERT INTO myapp_user_identifiers_public.webauthn_credentials (
    owner_id,
    credential_id,
    public_key,
    sign_count,
    transports,
    credential_device_type,
    backup_eligible,
    backup_state,
    webauthn_user_id,
    name
  )
  VALUES
    (webauthn_finish_registration.user_id, webauthn_finish_registration.credential_id, webauthn_finish_registration.public_key, webauthn_finish_registration.sign_count, webauthn_finish_registration.transports, webauthn_finish_registration.credential_device_type, webauthn_finish_registration.backup_eligible, webauthn_finish_registration.backup_state, webauthn_finish_registration.webauthn_user_id, webauthn_finish_registration.name)
  RETURNING id INTO v_new_id;
  DELETE FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_finish_registration.user_id AND action = 'webauthn_finish_registration';
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (webauthn_finish_registration.user_id, 'webauthn_finish_registration', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_finish_registration';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_finish_registration';
  END IF;
  RETURN v_new_id;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

