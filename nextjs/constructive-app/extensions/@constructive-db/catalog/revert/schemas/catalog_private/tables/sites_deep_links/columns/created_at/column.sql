-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/created_at/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN created_at RESTRICT;