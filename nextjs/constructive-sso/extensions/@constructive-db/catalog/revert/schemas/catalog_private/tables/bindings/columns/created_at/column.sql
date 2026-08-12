-- Revert: schemas/catalog_private/tables/bindings/columns/created_at/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN created_at RESTRICT;