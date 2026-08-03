-- Deploy: schemas/myapp_storage_public/tables/app_files/policies/auth_sel_pub/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_files/policies/enable_row_level_security


CREATE POLICY auth_sel_pub ON myapp_storage_public.app_files
FOR SELECT
TO authenticated
USING (
  is_public = true
);

