-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/email_mfa_enabled/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN email_mfa_enabled RESTRICT;


