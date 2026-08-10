-- Deploy: schemas/routing_public/tables/site_metadata/columns/canonical_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/columns/canonical_url/column


COMMENT ON COLUMN routing_public.site_metadata.canonical_url IS 'Canonical URL emitted in <link rel="canonical"> for this site';