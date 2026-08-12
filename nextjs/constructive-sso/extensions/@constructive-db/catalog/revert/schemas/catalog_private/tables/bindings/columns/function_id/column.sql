-- Revert: schemas/catalog_private/tables/bindings/columns/function_id/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN function_id RESTRICT;