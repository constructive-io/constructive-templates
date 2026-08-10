-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/columns/description/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/columns/description/column


COMMENT ON COLUMN myapp_capabilities_public.app_capabilities.description IS E'Human-readable description of what this capability allows';

