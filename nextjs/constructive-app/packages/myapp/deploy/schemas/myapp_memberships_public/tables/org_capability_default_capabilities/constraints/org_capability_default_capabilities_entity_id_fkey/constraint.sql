-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/constraints/org_capability_default_capabilities_entity_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ADD CONSTRAINT org_capability_default_capabilities_entity_id_fkey 
    FOREIGN KEY(entity_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;

