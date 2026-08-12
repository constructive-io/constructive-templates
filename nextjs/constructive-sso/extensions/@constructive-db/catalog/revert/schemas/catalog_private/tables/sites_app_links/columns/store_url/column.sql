-- Revert: schemas/catalog_private/tables/sites_app_links/columns/store_url/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN store_url RESTRICT;