-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/capability_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/capability_id/column


COMMENT ON COLUMN myapp_memberships_public.app_capability_default_capabilities.capability_id IS 'References the capability included in the defaults bundle';

