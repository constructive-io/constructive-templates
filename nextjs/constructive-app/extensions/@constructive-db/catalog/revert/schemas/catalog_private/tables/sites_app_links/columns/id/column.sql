-- Revert: schemas/catalog_private/tables/sites_app_links/columns/id/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN id RESTRICT;