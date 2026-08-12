-- Revert: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN sha256_cert_fingerprints RESTRICT;