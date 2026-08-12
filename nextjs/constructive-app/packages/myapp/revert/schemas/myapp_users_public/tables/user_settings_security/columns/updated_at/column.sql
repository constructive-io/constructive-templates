-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/updated_at/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN updated_at RESTRICT;


