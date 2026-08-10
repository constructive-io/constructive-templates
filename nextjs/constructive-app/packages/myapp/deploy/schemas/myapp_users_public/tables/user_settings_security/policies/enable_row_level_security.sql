-- Deploy: schemas/myapp_users_public/tables/user_settings_security/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


ALTER TABLE myapp_users_public.user_settings_security 
  ENABLE ROW LEVEL SECURITY;

