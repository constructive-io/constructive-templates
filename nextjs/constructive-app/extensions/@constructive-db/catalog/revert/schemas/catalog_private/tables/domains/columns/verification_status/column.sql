-- Revert: schemas/catalog_private/tables/domains/columns/verification_status/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN verification_status RESTRICT;