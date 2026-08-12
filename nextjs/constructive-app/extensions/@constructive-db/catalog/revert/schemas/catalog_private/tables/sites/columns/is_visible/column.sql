-- Revert: schemas/catalog_private/tables/sites/columns/is_visible/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN is_visible RESTRICT;