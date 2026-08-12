-- Revert: schemas/catalog_private/tables/bindings/columns/is_visible/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN is_visible RESTRICT;