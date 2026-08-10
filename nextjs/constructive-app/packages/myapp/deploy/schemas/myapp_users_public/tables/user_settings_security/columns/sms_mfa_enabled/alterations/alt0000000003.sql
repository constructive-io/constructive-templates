-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/sms_mfa_enabled/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/sms_mfa_enabled/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.sms_mfa_enabled IS E'Whether SMS-based MFA codes are active for this user';

