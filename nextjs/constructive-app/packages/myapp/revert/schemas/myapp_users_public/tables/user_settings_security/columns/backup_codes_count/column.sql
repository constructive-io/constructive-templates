-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/backup_codes_count/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN backup_codes_count RESTRICT;


