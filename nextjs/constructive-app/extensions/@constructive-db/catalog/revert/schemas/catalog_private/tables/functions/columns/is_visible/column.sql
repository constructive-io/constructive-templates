-- Revert: schemas/catalog_private/tables/functions/columns/is_visible/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN is_visible RESTRICT;