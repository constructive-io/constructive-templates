-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/created_at/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN created_at RESTRICT;