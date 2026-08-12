-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN id DROP NOT NULL;