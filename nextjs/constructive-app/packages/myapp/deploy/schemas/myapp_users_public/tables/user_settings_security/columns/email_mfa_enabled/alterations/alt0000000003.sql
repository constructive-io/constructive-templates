-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/email_mfa_enabled/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/email_mfa_enabled/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.email_mfa_enabled IS E'Whether email-based MFA codes are active for this user';

