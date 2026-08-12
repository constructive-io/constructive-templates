-- Deploy: schemas/myapp_auth_public/procedures/require_step_up/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_public.require_step_up(
  IN step_up_type text DEFAULT 'fresh_auth'
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_session myapp_auth_private.sessions;
  v_credential myapp_auth_private.session_credentials;
  v_settings myapp_auth_private.app_settings_auth;
  v_step_up_window interval := '30 minutes'::interval;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.sessions AS s
  WHERE
    s.id = v_session_id INTO v_session;
  SELECT *
  FROM myapp_auth_private.session_credentials AS sc
  WHERE
    sc.session_id = v_session_id INTO v_credential;
  IF v_credential.kind = 'api_key' AND v_credential.mfa_level = 'verified' THEN
    RETURN true;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  v_step_up_window := COALESCE(v_settings.step_up_window, '30 minutes'::interval);
  IF require_step_up.step_up_type = 'password' THEN
    IF v_session.last_password_verified IS NULL OR v_session.last_password_verified < (now() - v_step_up_window) THEN
      PERFORM errors.raise_error('STEP_UP_REQUIRED_PASSWORD', '{}', 'public');
    END IF;
  ELSE
    IF require_step_up.step_up_type = 'mfa' THEN
      IF v_session.last_mfa_verified IS NULL OR v_session.last_mfa_verified < (now() - v_step_up_window) THEN
        PERFORM errors.raise_error('STEP_UP_REQUIRED_MFA', '{}', 'public');
      END IF;
    ELSE
      IF require_step_up.step_up_type = 'fresh_auth' OR require_step_up.step_up_type = 'password_or_mfa' THEN
        IF ((v_session.last_password_verified IS NULL OR v_session.last_password_verified < (now() - v_step_up_window)) AND (v_session.last_mfa_verified IS NULL OR v_session.last_mfa_verified < (now() - v_step_up_window))) AND (v_session.last_idp_verified IS NULL OR v_session.last_idp_verified < (now() - v_step_up_window)) THEN
          PERFORM errors.raise_error('STEP_UP_REQUIRED_FRESH_AUTH', '{}', 'public');
        END IF;
      ELSE
        PERFORM errors.raise_error('STEP_UP_INVALID_TYPE', '{}', 'public');
      END IF;
    END IF;
  END IF;
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

