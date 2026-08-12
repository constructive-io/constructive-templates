-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table


ALTER TABLE catalog_private.sites_app_links 
  ADD COLUMN sha256_cert_fingerprints text[];