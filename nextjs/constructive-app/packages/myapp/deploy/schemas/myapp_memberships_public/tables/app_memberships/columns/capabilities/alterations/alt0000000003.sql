-- Deploy: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/column


COMMENT ON COLUMN myapp_memberships_public.app_memberships.capabilities IS E'Aggregated capability bitmask combining profile-based and directly granted capabilities';

