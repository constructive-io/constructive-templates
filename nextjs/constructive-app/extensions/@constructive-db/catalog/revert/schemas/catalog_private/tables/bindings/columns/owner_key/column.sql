-- Revert: schemas/catalog_private/tables/bindings/columns/owner_key/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN owner_key RESTRICT;