-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/kind/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/columns/kind/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ALTER COLUMN kind SET NOT NULL;

