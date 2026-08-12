-- Revert: schemas/catalog_private/tables/apps/columns/owner_scope/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN owner_scope RESTRICT;