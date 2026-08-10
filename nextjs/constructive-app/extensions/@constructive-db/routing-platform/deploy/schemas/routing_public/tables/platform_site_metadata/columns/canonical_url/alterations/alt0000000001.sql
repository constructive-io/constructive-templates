-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/canonical_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/canonical_url/column


COMMENT ON COLUMN routing_public.platform_site_metadata.canonical_url IS 'Canonical URL emitted in <link rel="canonical"> for this site';