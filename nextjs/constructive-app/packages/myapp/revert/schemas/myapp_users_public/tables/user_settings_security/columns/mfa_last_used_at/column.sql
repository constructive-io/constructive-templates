-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_last_used_at/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN mfa_last_used_at RESTRICT;


