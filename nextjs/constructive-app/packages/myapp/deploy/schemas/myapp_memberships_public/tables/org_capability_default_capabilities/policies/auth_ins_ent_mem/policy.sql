-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/policies/auth_ins_ent_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/policies/enable_row_level_security


CREATE POLICY auth_ins_ent_mem ON myapp_memberships_public.org_capability_default_capabilities
FOR INSERT
TO authenticated
WITH CHECK (
  entity_id IN (SELECT org_sprt.entity_id
  FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
  WHERE
      org_sprt.actor_id = ((SELECT jwt_public.current_principal_id())) AND (org_sprt.capabilities & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
);

