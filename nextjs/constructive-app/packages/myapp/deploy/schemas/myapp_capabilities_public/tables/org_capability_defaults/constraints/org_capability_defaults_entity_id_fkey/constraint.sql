-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/constraints/org_capability_defaults_entity_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  ADD CONSTRAINT org_capability_defaults_entity_id_fkey 
    FOREIGN KEY(entity_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;

