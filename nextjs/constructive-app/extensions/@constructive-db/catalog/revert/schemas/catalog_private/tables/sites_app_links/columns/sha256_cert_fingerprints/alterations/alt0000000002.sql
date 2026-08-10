-- Revert: schemas/catalog_private/tables/sites_app_links/columns/sha256_cert_fingerprints/alterations/alt0000000002


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN sha256_cert_fingerprints DROP DEFAULT;