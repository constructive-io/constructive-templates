-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/policies/auth_sel_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/policies/enable_row_level_security


CREATE POLICY auth_sel_dir_own ON myapp_auth_private.auth_user_devices
FOR SELECT
TO authenticated
USING (
  user_id = jwt_public.current_principal_id()
);

