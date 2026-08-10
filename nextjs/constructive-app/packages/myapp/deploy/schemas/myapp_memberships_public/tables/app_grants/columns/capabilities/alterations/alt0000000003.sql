-- Deploy: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/column


COMMENT ON COLUMN myapp_memberships_public.app_grants.capabilities IS 'Bitmask of capabilities being granted or revoked';

