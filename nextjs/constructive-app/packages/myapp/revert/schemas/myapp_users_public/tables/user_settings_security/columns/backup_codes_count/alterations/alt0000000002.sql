-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/alterations/alt0000000002


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN backup_codes_count DROP DEFAULT;


