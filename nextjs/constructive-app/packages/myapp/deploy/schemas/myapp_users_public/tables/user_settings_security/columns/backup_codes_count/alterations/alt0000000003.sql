-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/column


COMMENT ON COLUMN myapp_users_public.user_settings_security.backup_codes_count IS 'Number of remaining unused backup codes';

