-- Deploy: schemas/myapp_auth_private/procedures/sign_up_identity/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_user_identifiers_public/tables/emails/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


CREATE FUNCTION myapp_auth_private.sign_up_identity(
  IN service text,
  IN identifier text,
  IN email text,
  IN details jsonb DEFAULT NULL,
  IN credential_kind text DEFAULT 'access_token',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT out_device_token text
) AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_email myapp_user_identifiers_public.emails;
  v_default_session_duration interval := '2 weeks'::interval;
  v_remember_me_duration interval := '30 days'::interval;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_device_token_hash bytea;
  v_device_settings myapp_auth_private.app_settings_device;
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
  SELECT jwt_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(jwt_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_up_identity'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_up_identity') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sign_up, true)) THEN
    PERFORM errors.raise_error('SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF NOT (COALESCE(v_settings.allow_identity_sign_up, false)) THEN
    PERFORM errors.raise_error('IDENTITY_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('identity' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  SELECT *
  FROM myapp_user_identifiers_public.emails AS t
  WHERE
    trim(sign_up_identity.email) = t.email INTO v_email;
  IF v_email.owner_id IS NOT NULL THEN
    PERFORM errors.raise_error('ACCOUNT_EXISTS', '{}', 'public');
  END IF;
  v_user_id := myapp_auth_public.provision_new_user(trim(sign_up_identity.email));
  INSERT INTO myapp_user_identifiers_private.connected_accounts (
    owner_id,
    service,
    identifier,
    details,
    is_verified
  )
  VALUES
    (v_user_id, sign_up_identity.service, sign_up_identity.identifier, sign_up_identity.details, COALESCE((sign_up_identity.details->>'email_verified')::boolean, false));
  PERFORM myapp_store_private.user_state_set(v_user_id, 'primary_auth_method', 'identity'::text);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  v_session_id := uuidv7();
  IF sign_up_identity.remember_me IS TRUE THEN
    v_session_expires_at := now() + v_remember_me_duration;
  ELSE
    v_session_expires_at := now() + v_default_session_duration;
  END IF;
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id, v_user_id, false, v_session_expires_at, v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  v_plaintext_credential := (CASE 
    WHEN sign_up_identity.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_up_identity.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_up_identity.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_up_identity.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_up_identity.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_up_identity.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
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
    (v_credential_id, v_session_id, sign_up_identity.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  SELECT *
  FROM myapp_auth_private.app_settings_device
  LIMIT
  1 INTO v_device_settings;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF sign_up_identity.device_token IS NOT NULL THEN
      SELECT digest(sign_up_identity.device_token, 'sha256') INTO v_device_token_hash;
    ELSE
      SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
      SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
    END IF;
    INSERT INTO myapp_auth_private.auth_user_devices (
      user_id,
      device_token_hash,
      first_seen_ip,
      last_seen_ip,
      user_agent,
      origin,
      is_approved,
      approved_at,
      approval_method
    )
    VALUES
      (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin(), true, now(), 'auto');
  END IF;
  SELECT
    COALESCE(v_new_device_token, sign_up_identity.device_token) INTO out_device_token;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_up_identity';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_up_identity';
  END IF;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

