-- Deploy: schemas/myapp_users_public/tables/user_settings_security/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


COMMENT ON TABLE myapp_users_public.user_settings_security IS E'Per-user security settings for MFA configuration (separate from user_settings preferences)';

