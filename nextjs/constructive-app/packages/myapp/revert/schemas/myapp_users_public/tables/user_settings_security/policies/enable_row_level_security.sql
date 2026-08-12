-- Revert: schemas/myapp_users_public/tables/user_settings_security/policies/enable_row_level_security


ALTER TABLE myapp_users_public.user_settings_security 
  DISABLE ROW LEVEL SECURITY;


