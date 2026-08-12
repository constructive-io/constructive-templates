-- Revert: schemas/catalog_private/tables/apis/columns/name/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN name RESTRICT;