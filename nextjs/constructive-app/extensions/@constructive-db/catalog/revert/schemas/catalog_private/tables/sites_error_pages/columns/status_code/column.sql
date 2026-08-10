-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/status_code/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN status_code RESTRICT;