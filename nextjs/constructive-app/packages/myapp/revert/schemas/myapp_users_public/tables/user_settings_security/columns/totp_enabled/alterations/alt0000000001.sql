-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/totp_enabled/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN totp_enabled DROP NOT NULL;


