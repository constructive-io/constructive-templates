-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/owner_scope/column


ALTER TABLE catalog_private.sites_deep_links 
  DROP COLUMN owner_scope RESTRICT;