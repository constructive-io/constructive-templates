-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/constraints/org_capability_default_capabilities_capability_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ADD CONSTRAINT org_capability_default_capabilities_capability_id_fkey 
    FOREIGN KEY(capability_id) 
    REFERENCES myapp_capabilities_public.org_capabilities (id) 
    ON DELETE CASCADE;

