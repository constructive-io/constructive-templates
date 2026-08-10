-- Revert: schemas/myapp_users_public/tables/user_settings_security/columns/owner_id/column


ALTER TABLE myapp_users_public.user_settings_security 
  DROP COLUMN owner_id RESTRICT;


