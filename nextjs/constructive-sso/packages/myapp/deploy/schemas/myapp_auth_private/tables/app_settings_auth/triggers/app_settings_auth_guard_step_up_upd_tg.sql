-- Deploy: schemas/myapp_auth_private/tables/app_settings_auth/triggers/app_settings_auth_guard_step_up_upd_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_app_private/trigger_fns/app_settings_auth_guard_step_up_upd_fn


CREATE TRIGGER app_settings_auth_guard_step_up_upd_tg
BEFORE UPDATE ON myapp_auth_private.app_settings_auth
FOR EACH ROW
WHEN ((NEW.step_up_window IS DISTINCT FROM OLD.step_up_window OR NEW.require_mfa IS DISTINCT FROM OLD.require_mfa OR NEW.require_csrf_for_auth IS DISTINCT FROM OLD.require_csrf_for_auth OR NEW.enforce_primary_auth_method IS DISTINCT FROM OLD.enforce_primary_auth_method OR NEW.allowed_auth_methods IS DISTINCT FROM OLD.allowed_auth_methods OR NEW.min_password_length IS DISTINCT FROM OLD.min_password_length OR NEW.allow_sign_up IS DISTINCT FROM OLD.allow_sign_up OR NEW.allow_password_sign_in IS DISTINCT FROM OLD.allow_password_sign_in OR NEW.allow_identity_sign_in IS DISTINCT FROM OLD.allow_identity_sign_in OR NEW.allow_magic_link_sign_in IS DISTINCT FROM OLD.allow_magic_link_sign_in OR NEW.allow_email_otp_sign_in IS DISTINCT FROM OLD.allow_email_otp_sign_in OR NEW.allow_sms_sign_in IS DISTINCT FROM OLD.allow_sms_sign_in OR NEW.allow_webauthn_sign_in IS DISTINCT FROM OLD.allow_webauthn_sign_in OR NEW.allow_webauthn_usernameless IS DISTINCT FROM OLD.allow_webauthn_usernameless OR NEW.allow_anonymous_sessions IS DISTINCT FROM OLD.allow_anonymous_sessions OR NEW.allow_cross_origin_token IS DISTINCT FROM OLD.allow_cross_origin_token OR NEW.allow_api_keys IS DISTINCT FROM OLD.allow_api_keys OR NEW.allow_totp_mfa IS DISTINCT FROM OLD.allow_totp_mfa OR NEW.allow_email_mfa IS DISTINCT FROM OLD.allow_email_mfa OR NEW.allow_sms_mfa IS DISTINCT FROM OLD.allow_sms_mfa OR NEW.allow_backup_codes IS DISTINCT FROM OLD.allow_backup_codes OR NEW.allowed_origins IS DISTINCT FROM OLD.allowed_origins OR NEW.cookie_secure IS DISTINCT FROM OLD.cookie_secure OR NEW.cookie_samesite IS DISTINCT FROM OLD.cookie_samesite OR NEW.enable_captcha IS DISTINCT FROM OLD.enable_captcha OR NEW.oauth_require_verified_email IS DISTINCT FROM OLD.oauth_require_verified_email) AND OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.app_settings_auth_guard_step_up_upd_fn ( );

