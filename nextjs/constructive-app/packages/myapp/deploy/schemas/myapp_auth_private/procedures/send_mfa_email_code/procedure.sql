-- Deploy: schemas/myapp_auth_private/procedures/send_mfa_email_code/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_rate_limits/table


CREATE FUNCTION myapp_auth_private.send_mfa_email_code(
  IN user_id uuid
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_code text;
  v_email myapp_user_identifiers_public.emails;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_email_mfa_secret text;
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
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_mfa_email_code'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'mfa_email_code') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  v_user_id := send_mfa_email_code.user_id;
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('INVALID_USER', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('send_mfa_email_code'), hashtext(v_user_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'send_mfa_email_code' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS ue
  WHERE
    ue.owner_id = v_user_id AND ue.is_primary = true INTO v_email;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  v_email_mfa_secret := myapp_store_private.user_state_get(v_user_id, 'email_mfa_secret');
  IF v_email_mfa_secret IS NULL THEN
    v_email_mfa_secret := encode(gen_random_bytes(20), 'hex');
    PERFORM myapp_store_private.user_state_set(v_user_id, 'email_mfa_secret', v_email_mfa_secret);
  END IF;
  v_code := totp.generate(v_email_mfa_secret, 600, 6);
  PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('email_type', 'mfa_verification_code', 'user_id', v_user_id::text, 'email', v_email.email, 'code', v_code));
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'send_mfa_email_code', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'mfa_email_code';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'mfa_email_code';
  END IF;
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

