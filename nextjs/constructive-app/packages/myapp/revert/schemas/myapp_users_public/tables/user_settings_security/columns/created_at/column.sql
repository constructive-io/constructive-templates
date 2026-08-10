-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/created_at/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN created_at RESTRICT;


