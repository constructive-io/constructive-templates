-- Revert: schemas/catalog_private/tables/bindings/columns/updated_at/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN updated_at RESTRICT;