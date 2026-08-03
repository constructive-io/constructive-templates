-- Deploy: schemas/myapp_auth_public/tables/principals/policies/auth_sel_ent_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/policies/enable_row_level_security


CREATE POLICY auth_sel_ent_mem ON myapp_auth_public.principals
FOR SELECT
TO authenticated
USING (
  owner_id IN (SELECT org_sprt.entity_id
  FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
  WHERE
      org_sprt.actor_id = jwt_public.current_principal_id() AND org_sprt.is_admin IS TRUE)
);

