-- Deploy: schemas/myapp_storage_public/tables/app_buckets/policies/auth_del_adm/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/policies/enable_row_level_security


CREATE POLICY auth_del_adm ON myapp_storage_public.app_buckets
FOR DELETE
TO authenticated
USING (
  EXISTS (SELECT 1
  FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
  WHERE
      app_sprt.actor_id = ((SELECT jwt_public.current_principal_id())) AND app_sprt.is_admin IS TRUE)
);

