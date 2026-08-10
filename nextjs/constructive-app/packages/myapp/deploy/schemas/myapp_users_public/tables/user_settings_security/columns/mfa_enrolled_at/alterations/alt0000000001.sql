-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_enrolled_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_enrolled_at/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.mfa_enrolled_at IS 'When the first MFA method was enabled';

