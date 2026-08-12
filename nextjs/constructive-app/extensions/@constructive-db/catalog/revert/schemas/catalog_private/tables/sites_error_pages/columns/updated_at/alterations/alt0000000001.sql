-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN updated_at DROP DEFAULT;