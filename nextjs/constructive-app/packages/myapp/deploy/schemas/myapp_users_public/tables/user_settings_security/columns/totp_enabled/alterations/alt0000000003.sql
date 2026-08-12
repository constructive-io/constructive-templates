-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/totp_enabled/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/totp_enabled/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.totp_enabled IS E'Whether TOTP (authenticator app) MFA is active for this user';

