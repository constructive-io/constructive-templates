-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/object_path/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN object_path DROP NOT NULL;