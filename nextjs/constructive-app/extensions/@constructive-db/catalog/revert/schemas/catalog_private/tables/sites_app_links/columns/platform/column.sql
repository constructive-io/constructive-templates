-- Revert: schemas/catalog_private/tables/sites_app_links/columns/platform/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN platform RESTRICT;