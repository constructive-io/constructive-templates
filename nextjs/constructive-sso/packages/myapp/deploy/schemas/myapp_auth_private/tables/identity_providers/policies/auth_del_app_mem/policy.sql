-- Deploy: schemas/myapp_auth_private/tables/identity_providers/policies/auth_del_app_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/policies/enable_row_level_security


CREATE POLICY auth_del_app_mem ON myapp_auth_private.identity_providers
FOR DELETE
TO authenticated
USING (
  EXISTS (SELECT 1
  FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
  WHERE
      app_sprt.actor_id = ((SELECT jwt_public.current_principal_id())) AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000100000000') = '0000000000000000000000000000000000000000000000000000000100000000')
);

