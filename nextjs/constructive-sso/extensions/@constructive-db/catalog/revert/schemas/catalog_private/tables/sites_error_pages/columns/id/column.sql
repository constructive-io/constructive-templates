-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/id/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN id RESTRICT;