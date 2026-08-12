-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/site_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN site_id DROP NOT NULL;