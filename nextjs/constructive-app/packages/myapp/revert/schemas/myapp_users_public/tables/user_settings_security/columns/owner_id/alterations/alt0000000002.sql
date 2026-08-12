-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/owner_id/alterations/alt0000000002


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN owner_id DROP DEFAULT;


