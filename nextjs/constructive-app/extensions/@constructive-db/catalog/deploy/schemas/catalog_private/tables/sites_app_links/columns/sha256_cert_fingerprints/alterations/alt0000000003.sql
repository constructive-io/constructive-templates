-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/column


COMMENT ON COLUMN catalog_private.sites_app_links.sha256_cert_fingerprints IS 'Android signing certificate SHA-256 fingerprints, propagated from the source row';