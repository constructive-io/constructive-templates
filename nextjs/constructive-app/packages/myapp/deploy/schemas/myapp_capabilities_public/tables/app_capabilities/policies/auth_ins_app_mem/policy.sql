-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/policies/auth_ins_app_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/policies/enable_row_level_security


CREATE POLICY auth_ins_app_mem ON myapp_capabilities_public.app_capabilities
FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (SELECT 1
  FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
  WHERE
      app_sprt.actor_id = ((SELECT jwt_public.current_principal_id())) AND (app_sprt.capabilities & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
);

