-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/updated_at/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN updated_at RESTRICT;