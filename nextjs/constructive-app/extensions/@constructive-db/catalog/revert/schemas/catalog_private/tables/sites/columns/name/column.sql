-- Revert: schemas/catalog_private/tables/sites/columns/name/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN name RESTRICT;