-- Deploy: schemas/myapp_auth_private/procedures/request_magic_link/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_user_identifiers_public/tables/emails/table


CREATE FUNCTION myapp_auth_private.request_magic_link(
  IN email text,
  OUT token text,
  OUT success boolean
) AS $_PGFN_$
DECLARE
  v_settings myapp_auth_private.app_settings_auth;
  v_token text;
  v_token_hash text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_private.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_private.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_request_magic_link'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'request_magic_link') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_magic_link_sign_in, false)) THEN
    PERFORM errors.raise_error('MAGIC_LINK_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  v_token := (CASE 
    WHEN 'one_time' = 'api_key' THEN 'cnc_live_sk_' 
    WHEN 'one_time' = 'bearer' THEN 'cnc_live_bt_' 
    WHEN 'one_time' = 'access_token' THEN 'cnc_live_at_' 
    WHEN 'one_time' = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN 'one_time' = 'one_time' THEN 'cnc_live_ot_' 
    WHEN 'one_time' = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_token_hash := encode(digest(v_token, 'sha256'), 'hex');
  PERFORM myapp_store_private.user_state_set(uuid_nil(), concat('magic_link_email:', v_token_hash), trim(request_magic_link.email));
  PERFORM app_jobs.add_job('email:send_magic_link', json_build_object('email', trim(request_magic_link.email), 'magic_token', v_token));
  SELECT v_token INTO token;
  SELECT true INTO success;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'request_magic_link';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'request_magic_link';
  END IF;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

