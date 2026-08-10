-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN updated_at DROP DEFAULT;


