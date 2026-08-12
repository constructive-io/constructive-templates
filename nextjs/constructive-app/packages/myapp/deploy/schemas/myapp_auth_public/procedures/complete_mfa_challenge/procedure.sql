-- Deploy: schemas/myapp_auth_public/procedures/complete_mfa_challenge/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/auth_rate_limits/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE FUNCTION myapp_auth_public.complete_mfa_challenge(
  IN user_id uuid,
  IN mfa_challenge_token text,
  IN totp_code text,
  IN mfa_method text DEFAULT NULL,
  IN credential_kind text DEFAULT 'bearer',
  IN remember_me boolean DEFAULT false,
  IN trust_device boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  IN auth_method text DEFAULT NULL,
  OUT id uuid,
  OUT out_user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT is_verified boolean,
  OUT out_device_token text,
  OUT device_approval_required boolean
) RETURNS record AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_stored_token text;
  v_challenge_created_at text;
  v_totp_secret text;
  v_settings myapp_auth_private.app_settings_auth;
  v_security_settings myapp_users_public.user_settings_security;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_default_session_duration interval := '2 weeks'::interval;
  v_user_is_verified boolean := false;
  v_verified boolean := false;
  v_email_mfa_secret text;
  v_sms_mfa_secret text;
  v_backup_codes text;
  v_remember_me_duration interval := '30 days'::interval;
  v_device_token_hash bytea;
  v_device myapp_auth_private.auth_user_devices;
  v_device_settings myapp_auth_private.app_settings_device;
  v_new_device_token text;
  v_device_approved boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
BEGIN
  v_user_id := complete_mfa_challenge.user_id;
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('INVALID_MFA_CHALLENGE', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('complete_mfa_challenge'), hashtext(v_user_id::text));
  v_stored_token := myapp_store_private.user_state_get(v_user_id, 'mfa_challenge_token');
  v_challenge_created_at := myapp_store_private.user_state_get(v_user_id, 'mfa_challenge_created_at');
  IF v_stored_token IS NULL OR v_stored_token <> complete_mfa_challenge.mfa_challenge_token THEN
    PERFORM errors.raise_error('INVALID_MFA_CHALLENGE', '{}', 'public');
  END IF;
  IF v_challenge_created_at IS NULL OR v_challenge_created_at::timestamptz < (now() - '10 minutes'::interval) THEN
    PERFORM errors.raise_error('MFA_CHALLENGE_EXPIRED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'complete_mfa_challenge' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_users_public.user_settings_security AS uss
  WHERE
    uss.owner_id = v_user_id INTO v_security_settings;
  IF ((complete_mfa_challenge.mfa_method = 'totp' OR complete_mfa_challenge.mfa_method IS NULL) AND v_security_settings.totp_enabled IS TRUE) AND v_verified IS NOT TRUE THEN
    v_totp_secret := myapp_store_private.user_state_get(v_user_id, 'totp_secret');
    IF totp.verify(v_totp_secret, complete_mfa_challenge.totp_code, 30, 6) IS TRUE THEN
      v_verified := true;
    END IF;
  END IF;
  IF ((complete_mfa_challenge.mfa_method = 'email' OR complete_mfa_challenge.mfa_method IS NULL) AND v_security_settings.email_mfa_enabled IS TRUE) AND v_verified IS NOT TRUE THEN
    v_email_mfa_secret := myapp_store_private.user_state_get(v_user_id, 'email_mfa_secret');
    IF totp.verify(v_email_mfa_secret, complete_mfa_challenge.totp_code, 600, 6) IS TRUE THEN
      v_verified := true;
    END IF;
  END IF;
  IF ((complete_mfa_challenge.mfa_method = 'sms' OR complete_mfa_challenge.mfa_method IS NULL) AND v_security_settings.sms_mfa_enabled IS TRUE) AND v_verified IS NOT TRUE THEN
    v_sms_mfa_secret := myapp_store_private.user_state_get(v_user_id, 'sms_mfa_secret');
    IF totp.verify(v_sms_mfa_secret, complete_mfa_challenge.totp_code, 600, 6) IS TRUE THEN
      v_verified := true;
    END IF;
  END IF;
  IF ((complete_mfa_challenge.mfa_method = 'backup' OR complete_mfa_challenge.mfa_method IS NULL) AND v_security_settings.backup_codes_count > 0) AND v_verified IS NOT TRUE THEN
    v_backup_codes := myapp_store_private.user_state_get(v_user_id, 'backup_codes');
    IF complete_mfa_challenge.totp_code = ANY( string_to_array(v_backup_codes, ',') ) THEN
      v_verified := true;
      PERFORM myapp_store_private.user_state_set(v_user_id, 'backup_codes', array_to_string(array_remove(string_to_array(v_backup_codes, ','), complete_mfa_challenge.totp_code), ','));
      UPDATE myapp_users_public.user_settings_security SET
      backup_codes_count = backup_codes_count - 1
      WHERE
        owner_id = v_user_id;
    END IF;
  END IF;
  IF v_verified IS TRUE THEN
    SELECT *
    FROM myapp_auth_private.app_settings_device
    LIMIT
    1 INTO v_device_settings;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF complete_mfa_challenge.device_token IS NOT NULL THEN
        SELECT digest(complete_mfa_challenge.device_token, 'sha256') INTO v_device_token_hash;
        SELECT *
        FROM myapp_auth_private.auth_user_devices AS ud
        WHERE
          ud.user_id = v_user_id AND ud.device_token_hash = v_device_token_hash INTO v_device;
        IF v_device.is_approved IS TRUE THEN
          SELECT true INTO v_device_approved;
        END IF;
      ELSE
        SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
        SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
      END IF;
    END IF;
    IF v_device_settings.require_device_approval IS TRUE AND v_device_approved IS NOT TRUE THEN
      IF v_device.id IS NULL THEN
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          first_seen_ip,
          last_seen_ip,
          user_agent,
          origin
        )
        VALUES
          (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
      SELECT true INTO device_approval_required;
      SELECT v_user_id INTO user_id;
      SELECT
        COALESCE(v_new_device_token, complete_mfa_challenge.device_token) INTO out_device_token;
      RETURN;
    END IF;
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'complete_mfa_challenge';
    PERFORM myapp_store_private.user_state_del(v_user_id, ARRAY['mfa_challenge_token', 'mfa_challenge_created_at']);
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'complete_mfa_challenge', true);
    SELECT *
    FROM myapp_auth_private.app_settings_auth
    LIMIT
    1 INTO v_settings;
    v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
    v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
    IF complete_mfa_challenge.remember_me IS TRUE THEN
      v_session_expires_at := now() + v_remember_me_duration;
    ELSE
      v_session_expires_at := now() + v_default_session_duration;
    END IF;
    v_csrf_secret := encode(gen_random_bytes(32), 'hex');
    v_session_id := uuidv7();
    INSERT INTO myapp_auth_private.sessions (
      id,
      user_id,
      is_anonymous,
      expires_at,
      last_password_verified,
      last_mfa_verified,
      auth_method,
      csrf_secret,
      origin,
      uagent
    )
    VALUES
      (v_session_id, v_user_id, false, v_session_expires_at, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, COALESCE(complete_mfa_challenge.auth_method, 'password'), v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
    v_plaintext_credential := (CASE 
      WHEN complete_mfa_challenge.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
      WHEN complete_mfa_challenge.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
      WHEN complete_mfa_challenge.credential_kind = 'access_token' THEN 'cnc_live_at_' 
      WHEN complete_mfa_challenge.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
      WHEN complete_mfa_challenge.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
      WHEN complete_mfa_challenge.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
      ELSE 'cnc_live_tk_' 
    END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
    v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
    INSERT INTO myapp_auth_private.session_credentials (
      id,
      session_id,
      kind,
      secret_hash,
      expires_at,
      mfa_level
    )
    VALUES
      (v_credential_id, v_session_id, complete_mfa_challenge.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at, 'verified');
    SELECT
      membership_status.is_verified,
      membership_status.is_disabled,
      membership_status.is_banned
    FROM myapp_memberships_public.app_memberships AS membership_status
    WHERE
      membership_status.actor_id = v_user_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
    SELECT v_credential_id INTO id;
    SELECT v_user_id INTO out_user_id;
    SELECT v_plaintext_credential INTO access_token;
    SELECT v_session_expires_at INTO access_token_expires_at;
    SELECT v_user_is_verified INTO is_verified;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF complete_mfa_challenge.trust_device IS TRUE AND v_device.id IS NOT NULL THEN
        UPDATE myapp_auth_private.auth_user_devices AS ud SET
        is_trusted = true, trusted_at = now(), trust_expires_at = now() + (COALESCE(v_device_settings.device_trust_duration, '30 days'::interval)), trust_method = 'mfa_verified'
        WHERE
          ud.id = v_device.id;
      END IF;
      IF v_device.id IS NOT NULL THEN
        UPDATE myapp_auth_private.auth_user_devices AS ud SET
        last_seen_at = now(), user_agent = jwt_public.current_user_agent()
        WHERE
          ud.id = v_device.id;
      ELSE
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          user_agent,
          origin
        )
        VALUES
          (v_user_id, v_device_token_hash, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
    END IF;
    SELECT
      COALESCE(v_new_device_token, complete_mfa_challenge.device_token) INTO out_device_token;
    RETURN;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'complete_mfa_challenge', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user_id, 'complete_mfa_challenge', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    RETURN;
  END IF;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

