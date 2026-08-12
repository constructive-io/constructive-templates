-- Deploy: schemas/myapp_auth_public/procedures/sign_in_sms_otp/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


CREATE FUNCTION myapp_auth_public.sign_in_sms_otp(
  IN phone text,
  IN code text,
  IN credential_kind text DEFAULT 'access_token',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT out_device_token text,
  OUT device_approval_required boolean
) AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_phone myapp_user_identifiers_public.phone_numbers;
  v_default_session_duration interval := '2 weeks'::interval;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_sms_otp_secret text;
  v_code_valid boolean := false;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_remember_me_duration interval := '30 days'::interval;
  v_device_token_hash bytea;
  v_device myapp_auth_private.auth_user_devices;
  v_device_settings myapp_auth_private.app_settings_device;
  v_device_trusted boolean := false;
  v_device_approved boolean := false;
  v_new_device_token text;
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
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_in_sms_otp'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_in_sms_otp') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sms_sign_in, false)) THEN
    PERFORM errors.raise_error('SMS_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('sms' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  v_sms_otp_secret := myapp_store_private.user_state_get(uuid_nil(), concat('sms_otp:', regexp_replace(sign_in_sms_otp.phone, '[^+0-9]', '', 'g')));
  IF v_sms_otp_secret IS NULL THEN
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
        (v_ip_address, v_ua_hash, 'sign_in_sms_otp', 1, now(), NULL)
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
        (v_ip_address, '', 'sign_in_sms_otp', 1, now(), NULL)
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
    RETURN;
  END IF;
  v_code_valid := totp.verify(v_sms_otp_secret, sign_in_sms_otp.code, 600, 6, now(), 'sha1', 'raw');
  IF NOT (COALESCE(v_code_valid, false)) THEN
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
        (v_ip_address, v_ua_hash, 'sign_in_sms_otp', 1, now(), NULL)
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
        (v_ip_address, '', 'sign_in_sms_otp', 1, now(), NULL)
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
    RETURN;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.phone_numbers AS pn
  WHERE
    pn.number = regexp_replace(sign_in_sms_otp.phone, '[^+0-9]', '', 'g') INTO v_phone;
  IF v_phone.owner_id IS NULL THEN
    PERFORM errors.raise_error('ACCOUNT_NOT_FOUND', '{}', 'public');
  END IF;
  v_user_id := v_phone.owner_id;
  SELECT
    membership_status.is_verified,
    membership_status.is_disabled,
    membership_status.is_banned
  FROM myapp_memberships_public.app_memberships AS membership_status
  WHERE
    membership_status.actor_id = v_user_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
  IF v_user_is_disabled IS TRUE OR v_user_is_banned IS TRUE THEN
    PERFORM errors.raise_error('ACCOUNT_DISABLED', '{}', 'public');
  END IF;
  IF COALESCE(v_settings.enforce_primary_auth_method, true) AND myapp_store_private.user_state_get(v_user_id, 'primary_auth_method') <> 'sms' THEN
    PERFORM errors.raise_error('PRIMARY_AUTH_METHOD_MISMATCH', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_device
  LIMIT
  1 INTO v_device_settings;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF sign_in_sms_otp.device_token IS NOT NULL THEN
      SELECT digest(sign_in_sms_otp.device_token, 'sha256') INTO v_device_token_hash;
      SELECT *
      FROM myapp_auth_private.auth_user_devices AS ud
      WHERE
        ud.user_id = v_user_id AND ud.device_token_hash = v_device_token_hash INTO v_device;
      IF v_device.is_trusted IS TRUE AND v_device.trust_expires_at > now() THEN
        SELECT true INTO v_device_trusted;
      END IF;
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
      COALESCE(v_new_device_token, sign_in_sms_otp.device_token) INTO out_device_token;
    RETURN;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'sign_in_sms_otp', true);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  v_session_id := uuidv7();
  IF sign_in_sms_otp.remember_me IS TRUE THEN
    v_session_expires_at := now() + v_remember_me_duration;
  ELSE
    v_session_expires_at := now() + v_default_session_duration;
  END IF;
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
    (v_session_id, v_user_id, false, v_session_expires_at, 'sms_otp', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  v_plaintext_credential := (CASE 
    WHEN sign_in_sms_otp.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_in_sms_otp.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_in_sms_otp.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_in_sms_otp.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_in_sms_otp.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_in_sms_otp.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id, v_session_id, sign_in_sms_otp.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF v_device.id IS NOT NULL THEN
      UPDATE myapp_auth_private.auth_user_devices AS ud SET
      last_seen_at = now(), last_seen_ip = v_ip_address, user_agent = jwt_public.current_user_agent()
      WHERE
        ud.id = v_device.id;
    ELSE
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
  END IF;
  SELECT
    COALESCE(v_new_device_token, sign_in_sms_otp.device_token) INTO out_device_token;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_in_sms_otp';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_in_sms_otp';
  END IF;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

