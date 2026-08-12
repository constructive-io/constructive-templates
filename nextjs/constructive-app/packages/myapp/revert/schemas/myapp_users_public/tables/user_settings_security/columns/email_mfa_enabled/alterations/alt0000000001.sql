-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/email_mfa_enabled/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN email_mfa_enabled DROP NOT NULL;


