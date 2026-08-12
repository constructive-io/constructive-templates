-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/column


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  ALTER COLUMN entity_id SET NOT NULL;

