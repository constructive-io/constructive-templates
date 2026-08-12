-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN is_visible DROP DEFAULT;