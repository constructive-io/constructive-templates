-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitnum/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitnum/column


COMMENT ON COLUMN myapp_capabilities_public.app_capabilities.bitnum IS E'Position of this capability in the bitmask (1-indexed), must be unique per capability set';

