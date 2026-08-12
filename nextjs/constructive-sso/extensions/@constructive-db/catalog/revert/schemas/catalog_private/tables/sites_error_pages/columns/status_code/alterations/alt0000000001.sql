-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/status_code/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN status_code DROP NOT NULL;