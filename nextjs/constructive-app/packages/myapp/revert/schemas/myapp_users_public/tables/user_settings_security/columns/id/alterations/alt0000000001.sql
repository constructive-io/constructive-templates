-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/id/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN id DROP NOT NULL;


