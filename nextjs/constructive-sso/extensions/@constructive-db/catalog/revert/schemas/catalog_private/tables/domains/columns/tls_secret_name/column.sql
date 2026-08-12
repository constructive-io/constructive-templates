-- Revert: schemas/catalog_private/tables/domains/columns/tls_secret_name/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN tls_secret_name RESTRICT;