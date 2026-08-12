-- Revert: schemas/catalog_private/tables/domains/columns/hostname/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN hostname RESTRICT;