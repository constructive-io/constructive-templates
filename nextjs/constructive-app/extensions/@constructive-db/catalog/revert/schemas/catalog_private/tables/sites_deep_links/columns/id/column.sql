-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/id/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN id RESTRICT;