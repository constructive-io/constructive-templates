-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/auth_sel_all_all/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/enable_row_level_security


CREATE POLICY auth_sel_all_all ON myapp_capabilities_public.app_capability_defaults
FOR SELECT
TO authenticated
USING (
  TRUE
);

