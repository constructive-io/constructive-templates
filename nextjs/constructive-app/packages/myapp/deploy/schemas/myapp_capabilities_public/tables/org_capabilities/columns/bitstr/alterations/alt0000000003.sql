-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/column


COMMENT ON COLUMN myapp_capabilities_public.org_capabilities.bitstr IS E'Pre-computed bitmask with only this capability bit set, used for bitwise OR/AND operations';

