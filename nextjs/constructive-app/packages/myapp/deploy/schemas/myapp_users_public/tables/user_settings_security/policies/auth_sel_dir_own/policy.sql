-- Deploy: schemas/myapp_users_public/tables/user_settings_security/policies/auth_sel_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/policies/enable_row_level_security


CREATE POLICY auth_sel_dir_own ON myapp_users_public.user_settings_security
FOR SELECT
TO authenticated
USING (
  owner_id = ((SELECT jwt_public.current_principal_id()))
);

