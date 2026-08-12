-- Deploy: schemas/myapp_auth_public/procedures/get_mfa_status/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE FUNCTION myapp_auth_public.get_mfa_status(
  OUT totp_enabled boolean,
  OUT email_mfa_enabled boolean,
  OUT sms_mfa_enabled boolean,
  OUT backup_codes_count int
) RETURNS record AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_security_settings myapp_users_public.user_settings_security;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_users_public.user_settings_security AS uss
  WHERE
    uss.owner_id = v_user_id INTO v_security_settings;
  IF v_security_settings.owner_id IS NOT NULL THEN
    SELECT v_security_settings.totp_enabled INTO totp_enabled;
    SELECT v_security_settings.email_mfa_enabled INTO email_mfa_enabled;
    SELECT v_security_settings.sms_mfa_enabled INTO sms_mfa_enabled;
    SELECT v_security_settings.backup_codes_count INTO backup_codes_count;
  ELSE
    SELECT false INTO totp_enabled;
    SELECT false INTO email_mfa_enabled;
    SELECT false INTO sms_mfa_enabled;
    SELECT 0 INTO backup_codes_count;
  END IF;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

