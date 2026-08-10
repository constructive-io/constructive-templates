-- Revert: schemas/catalog_private/tables/domains/columns/tls_status/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN tls_status RESTRICT;