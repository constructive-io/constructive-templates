-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table
-- requires: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/column


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN sha256_cert_fingerprints SET NOT NULL;