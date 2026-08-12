-- Revert: schemas/catalog_private/tables/sites_app_links/columns/updated_at/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN updated_at RESTRICT;