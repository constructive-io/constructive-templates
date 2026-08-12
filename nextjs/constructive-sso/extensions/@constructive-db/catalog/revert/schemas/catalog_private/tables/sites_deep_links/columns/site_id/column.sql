-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/site_id/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN site_id RESTRICT;