-- Revert: schemas/catalog_private/tables/sites_app_links/columns/platform/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN platform DROP NOT NULL;