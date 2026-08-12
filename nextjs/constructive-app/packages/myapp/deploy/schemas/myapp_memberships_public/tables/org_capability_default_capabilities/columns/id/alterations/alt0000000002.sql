-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/id/column


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ALTER COLUMN id SET DEFAULT uuidv7();

