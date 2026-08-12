-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/column


COMMENT ON COLUMN myapp_capabilities_public.org_capability_defaults.entity_id IS 'References the entity these default capabilities apply to';

