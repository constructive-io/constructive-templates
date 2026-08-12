-- Revert: schemas/catalog_private/tables/sites_app_links/columns/owner_scope/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN owner_scope RESTRICT;