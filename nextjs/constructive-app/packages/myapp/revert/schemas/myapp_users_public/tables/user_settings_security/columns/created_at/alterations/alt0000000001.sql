-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN created_at DROP DEFAULT;


