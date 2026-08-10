-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/capabilities/column


COMMENT ON COLUMN myapp_capabilities_public.org_capability_defaults.capabilities IS 'Default capability bitmask applied to new members';

