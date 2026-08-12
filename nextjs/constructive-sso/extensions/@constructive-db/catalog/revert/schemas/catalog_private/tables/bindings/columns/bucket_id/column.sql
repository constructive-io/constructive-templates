-- Revert: schemas/catalog_private/tables/bindings/columns/bucket_id/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN bucket_id RESTRICT;