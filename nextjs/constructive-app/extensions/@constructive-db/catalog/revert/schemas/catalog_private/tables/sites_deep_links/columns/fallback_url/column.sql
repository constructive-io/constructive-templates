-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/fallback_url/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN fallback_url RESTRICT;