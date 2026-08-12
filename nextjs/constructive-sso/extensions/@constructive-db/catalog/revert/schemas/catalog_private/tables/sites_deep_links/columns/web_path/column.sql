-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/web_path/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN web_path RESTRICT;