-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN created_at DROP DEFAULT;