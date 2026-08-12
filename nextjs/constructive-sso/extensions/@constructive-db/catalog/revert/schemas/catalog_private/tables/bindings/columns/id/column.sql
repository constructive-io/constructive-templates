-- Revert: schemas/catalog_private/tables/bindings/columns/id/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN id RESTRICT;