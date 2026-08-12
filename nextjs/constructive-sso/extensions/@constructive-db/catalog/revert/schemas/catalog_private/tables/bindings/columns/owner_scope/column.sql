-- Revert: schemas/catalog_private/tables/bindings/columns/owner_scope/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN owner_scope RESTRICT;