-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/sms_mfa_enabled/alterations/alt0000000001


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN sms_mfa_enabled DROP NOT NULL;


