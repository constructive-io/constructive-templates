-- Revert: schemas/catalog_private/tables/namespaces/columns/is_visible/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN is_visible RESTRICT;