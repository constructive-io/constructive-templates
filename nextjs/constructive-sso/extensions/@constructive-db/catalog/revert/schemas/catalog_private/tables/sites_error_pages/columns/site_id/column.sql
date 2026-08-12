-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/site_id/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN site_id RESTRICT;