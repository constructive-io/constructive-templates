-- Revert: schemas/catalog_private/tables/apis/columns/is_visible/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN is_visible RESTRICT;