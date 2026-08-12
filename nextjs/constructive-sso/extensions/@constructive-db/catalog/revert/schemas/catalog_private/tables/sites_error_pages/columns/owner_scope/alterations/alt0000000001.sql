-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN owner_scope DROP NOT NULL;