-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/is_visible/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN is_visible RESTRICT;