-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/capability_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/capability_id/column


COMMENT ON COLUMN myapp_memberships_public.org_capability_default_grants.capability_id IS 'References the capability being added to or removed from defaults';

