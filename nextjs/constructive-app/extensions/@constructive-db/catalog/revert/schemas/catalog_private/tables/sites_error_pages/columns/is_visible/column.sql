-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/is_visible/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN is_visible RESTRICT;