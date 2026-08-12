-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/object_path/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN object_path RESTRICT;