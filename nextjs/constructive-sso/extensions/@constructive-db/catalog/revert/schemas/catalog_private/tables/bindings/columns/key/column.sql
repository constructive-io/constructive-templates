-- Revert: schemas/catalog_private/tables/bindings/columns/key/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN key RESTRICT;