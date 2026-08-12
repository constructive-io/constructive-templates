-- Deploy: schemas/routing_public/tables/platform_sites/columns/installation_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/columns/installation_id/column


COMMENT ON COLUMN routing_public.platform_sites.installation_id IS 'Catalog resource_installation (release) that backs this site; the servable member is named by installation_member_slug (exactly one of bucket_id/resource_id/installation_id)';