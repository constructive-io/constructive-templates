-- Deploy: schemas/myapp_auth_public/procedures/confirm_totp_setup/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/auth_rate_limits/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE FUNCTION myapp_auth_public.confirm_totp_setup(
  IN totp_value text
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_setup_secret text;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('confirm_totp_setup'), hashtext(v_user_id::text));
  v_setup_secret := myapp_store_private.user_state_get(v_user_id, 'totp_setup_secret');
  IF v_setup_secret IS NULL THEN
    PERFORM errors.raise_error('TOTP_SETUP_NOT_INITIATED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'confirm_totp_setup' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF totp.verify(v_setup_secret, confirm_totp_setup.totp_value, 30, 6) IS TRUE THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'confirm_totp_setup';
    PERFORM myapp_store_private.user_state_set(v_user_id, 'totp_secret', v_setup_secret);
    PERFORM myapp_store_private.user_state_del(v_user_id, ARRAY['totp_setup_secret']);
    UPDATE myapp_users_public.user_settings_security SET
    totp_enabled = true, mfa_enrolled_at = COALESCE(mfa_enrolled_at, CURRENT_TIMESTAMP), mfa_last_used_at = CURRENT_TIMESTAMP
    WHERE
      owner_id = v_user_id;
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'confirm_totp_setup', true);
    RETURN true;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'confirm_totp_setup', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user_id, 'confirm_totp_setup', 1, now(), now(), NULL)
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
    RETURN NULL;
  END IF;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

