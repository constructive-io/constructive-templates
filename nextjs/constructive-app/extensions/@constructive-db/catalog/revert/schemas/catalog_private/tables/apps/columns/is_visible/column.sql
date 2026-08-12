-- Revert: schemas/catalog_private/tables/apps/columns/is_visible/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN is_visible RESTRICT;