-- Revert: schemas/catalog_private/tables/namespaces/columns/owner_scope/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN owner_scope RESTRICT;