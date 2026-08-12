-- Deploy: schemas/myapp_auth_private/procedures/webauthn_finish_sign_in/procedure
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


CREATE FUNCTION myapp_auth_private.webauthn_finish_sign_in(
  IN credential_id text,
  IN new_sign_count bigint,
  IN new_backup_state boolean,
  IN credential_kind text DEFAULT 'access_token',
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz
) AS $_PGFN_$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_owner_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_default_session_duration interval := '2 weeks'::interval;
  v_session_expires_at timestamptz;
  v_session_id_new uuid;
  v_credential_id_new uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
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
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_finish_sign_in'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_finish_sign_in') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_in, false)) THEN
    PERFORM errors.raise_error('WEBAUTHN_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  v_session_id := jwt_private.current_session_id();
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = v_session_id AND s.name = 'webauthn_sign_in_challenge') AND (s.expires_at IS NULL OR s.expires_at > now())
  RETURNING s.value INTO v_challenge;
  IF v_challenge IS NULL THEN
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (NULL, 'webauthn_finish_sign_in_challenge_not_found', false);
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
        (v_ip_address, v_ua_hash, 'webauthn_finish_sign_in', 1, now(), NULL)
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
        (v_ip_address, '', 'webauthn_finish_sign_in', 1, now(), NULL)
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
    PERFORM errors.raise_error('WEBAUTHN_SIGN_IN_CHALLENGE_NOT_FOUND_OR_EXPIRED', '{}', 'public');
  END IF;
  UPDATE myapp_user_identifiers_public.webauthn_credentials AS c SET
  sign_count = webauthn_finish_sign_in.new_sign_count, backup_state = webauthn_finish_sign_in.new_backup_state, last_used_at = now()
  WHERE
    c.credential_id = webauthn_finish_sign_in.credential_id
  RETURNING c.owner_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (NULL, 'webauthn_finish_sign_in_credential_not_found', false);
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
        (v_ip_address, v_ua_hash, 'webauthn_finish_sign_in', 1, now(), NULL)
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
        (v_ip_address, '', 'webauthn_finish_sign_in', 1, now(), NULL)
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
    PERFORM errors.raise_error('WEBAUTHN_CREDENTIAL_NOT_FOUND', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_session_expires_at := now() + v_default_session_duration;
  v_session_id_new := uuidv7();
  v_plaintext_credential := (CASE 
    WHEN webauthn_finish_sign_in.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id_new := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    auth_method,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id_new, v_owner_id, false, v_session_expires_at, 'webauthn', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id_new, v_session_id_new, webauthn_finish_sign_in.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_owner_id, 'webauthn_finish_sign_in', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_finish_sign_in';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_finish_sign_in';
  END IF;
  SELECT v_owner_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

