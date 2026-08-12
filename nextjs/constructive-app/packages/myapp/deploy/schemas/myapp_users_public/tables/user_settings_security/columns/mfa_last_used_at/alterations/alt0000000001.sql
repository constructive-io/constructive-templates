-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_last_used_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_last_used_at/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.mfa_last_used_at IS 'When MFA was last successfully verified';

