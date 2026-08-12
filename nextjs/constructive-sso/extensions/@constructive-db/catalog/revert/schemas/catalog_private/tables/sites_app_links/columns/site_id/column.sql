-- Revert: schemas/catalog_private/tables/sites_app_links/columns/site_id/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN site_id RESTRICT;