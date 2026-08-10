-- Revert: schemas/catalog_private/tables/sites_app_links/columns/is_visible/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN is_visible RESTRICT;