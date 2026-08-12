-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/updated_at/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN updated_at RESTRICT;