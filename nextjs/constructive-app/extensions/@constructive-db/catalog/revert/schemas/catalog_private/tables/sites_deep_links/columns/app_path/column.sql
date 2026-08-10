-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/app_path/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN app_path RESTRICT;