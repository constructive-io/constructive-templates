-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/column


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ALTER COLUMN entity_id SET NOT NULL;

