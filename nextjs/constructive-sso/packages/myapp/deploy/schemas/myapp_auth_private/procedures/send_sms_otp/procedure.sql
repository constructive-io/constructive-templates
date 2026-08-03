-- Deploy: schemas/myapp_auth_private/procedures/send_sms_otp/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table


CREATE FUNCTION myapp_auth_private.send_sms_otp(
  IN phone text
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_settings myapp_auth_private.app_settings_auth;
  v_sms_otp_secret text;
  v_code text;
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
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_send_sms_otp'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'send_sms_otp') AND locked_until > now()
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
  v_sms_otp_secret := myapp_store_private.user_state_get(uuid_nil(), concat('sms_otp:', send_sms_otp.phone));
  IF v_sms_otp_secret IS NULL THEN
    v_sms_otp_secret := concat('\x', encode(gen_random_bytes(20), 'hex'));
    PERFORM myapp_store_private.user_state_set(uuid_nil(), concat('sms_otp:', send_sms_otp.phone), v_sms_otp_secret);
  END IF;
  v_code := totp.generate(v_sms_otp_secret, 600, 6, now(), 'sha1', 'raw');
  PERFORM app_jobs.add_job('sms:send_verification_code', json_build_object('sms_type', 'sms_otp_code', 'phone', send_sms_otp.phone, 'code', v_code));
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'send_sms_otp';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'send_sms_otp';
  END IF;
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

