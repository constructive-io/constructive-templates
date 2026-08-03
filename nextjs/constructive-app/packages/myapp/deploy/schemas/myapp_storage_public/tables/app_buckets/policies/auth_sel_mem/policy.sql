-- Deploy: schemas/myapp_storage_public/tables/app_buckets/policies/auth_sel_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/policies/enable_row_level_security


CREATE POLICY auth_sel_mem ON myapp_storage_public.app_buckets
FOR SELECT
TO authenticated
USING (
  EXISTS (SELECT 1
  FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
  WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
);

