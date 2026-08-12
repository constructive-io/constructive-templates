-- Revert: schemas/catalog_private/tables/sites_app_links/columns/created_at/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN created_at RESTRICT;