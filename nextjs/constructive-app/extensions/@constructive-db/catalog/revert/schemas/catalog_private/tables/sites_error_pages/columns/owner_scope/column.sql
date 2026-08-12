-- Revert: schemas/catalog_private/tables/sites_error_pages/columns/owner_scope/column


ALTER TABLE catalog_private.sites_error_pages 
  DROP COLUMN owner_scope RESTRICT;