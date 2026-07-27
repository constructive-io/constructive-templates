-- Deploy: schemas/myapp_auth_private/procedures/webauthn_begin_sign_in/procedure
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


CREATE FUNCTION myapp_auth_private.webauthn_begin_sign_in(
  IN user_id uuid DEFAULT NULL
) RETURNS jsonb AS $_PGFN_$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_expires_at timestamptz;
  v_settings myapp_auth_private.app_settings_auth;
  v_allow_credentials jsonb;
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
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_begin_sign_in'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_begin_sign_in') AND locked_until > now()
    LIMIT
    1) THEN
      RAISE EXCEPTION 'TOO_MANY_REQUESTS';
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_in, false)) THEN
    RAISE EXCEPTION 'WEBAUTHN_SIGN_IN_DISABLED';
  END IF;
  v_session_id := jwt_private.current_session_id();
  v_challenge := translate(encode(gen_random_bytes(32), 'base64'), '+/=', '-_');
  v_expires_at := now() + '5 minutes'::interval;
  INSERT INTO myapp_auth_private.session_secrets (
    session_id,
    name,
    value,
    expires_at
  )
  VALUES
    (v_session_id, 'webauthn_sign_in_challenge', v_challenge, v_expires_at)
  ON CONFLICT (session_id, name) DO UPDATE SET
  value = EXCLUDED.value, expires_at = EXCLUDED.expires_at;
  IF webauthn_begin_sign_in.user_id IS NOT NULL THEN
    SELECT
      COALESCE(jsonb_agg(jsonb_build_object('id', c.credential_id, 'type', 'public-key', 'transports', c.transports)), '[]'::jsonb)
    FROM myapp_user_identifiers_public.webauthn_credentials AS c
    WHERE
      c.owner_id = webauthn_begin_sign_in.user_id INTO v_allow_credentials;
  ELSE
    v_allow_credentials := '[]'::jsonb;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (webauthn_begin_sign_in.user_id, 'webauthn_begin_sign_in', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_begin_sign_in';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_begin_sign_in';
  END IF;
  RETURN jsonb_build_object('challenge', v_challenge, 'allowCredentials', v_allow_credentials);
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

