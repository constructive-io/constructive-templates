-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/column


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN backup_codes_count SET DEFAULT 0;

