-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/kind/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/columns/kind/column


COMMENT ON COLUMN myapp_capabilities_public.org_capabilities.kind IS E'Kind of catalog entry: capability (capability) or level (achievement level)';

