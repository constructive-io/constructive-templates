-- Revert: schemas/catalog_private/tables/sites/columns/owner_scope/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN owner_scope RESTRICT;