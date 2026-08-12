-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/column


COMMENT ON COLUMN myapp_memberships_public.org_capability_default_capabilities.entity_id IS 'Scopes this default capability to a specific entity';

