-- Revert: schemas/catalog_private/tables/bindings/columns/database_id/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN database_id RESTRICT;