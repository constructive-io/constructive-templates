-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/database_id/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN database_id RESTRICT;