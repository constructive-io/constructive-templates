-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/columns/name/column


COMMENT ON COLUMN myapp_capabilities_public.app_capabilities.name IS E'Human-readable capability name (e.g. read, write, manage)';

