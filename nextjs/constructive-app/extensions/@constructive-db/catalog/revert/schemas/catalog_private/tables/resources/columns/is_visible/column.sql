-- Revert: schemas/catalog_private/tables/resources/columns/is_visible/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN is_visible RESTRICT;