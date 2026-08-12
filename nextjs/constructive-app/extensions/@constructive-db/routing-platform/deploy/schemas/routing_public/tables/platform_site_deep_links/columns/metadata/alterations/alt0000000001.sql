-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/metadata/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/metadata/column


COMMENT ON COLUMN routing_public.platform_site_deep_links.metadata IS 'Additional link metadata (campaign/UTM parameters, escape hatch)';