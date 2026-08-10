-- Deploy: schemas/routing_public/tables/site_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/columns/sha256_cert_fingerprints/column


COMMENT ON COLUMN routing_public.site_app_links.sha256_cert_fingerprints IS 'Android signing certificate SHA-256 fingerprints for assetlinks.json';