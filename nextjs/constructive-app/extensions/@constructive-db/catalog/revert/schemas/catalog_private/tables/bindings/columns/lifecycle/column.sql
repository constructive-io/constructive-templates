-- Revert: schemas/catalog_private/tables/bindings/columns/lifecycle/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN lifecycle RESTRICT;