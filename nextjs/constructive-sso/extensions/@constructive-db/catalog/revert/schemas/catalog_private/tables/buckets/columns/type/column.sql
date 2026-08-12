-- Revert: schemas/catalog_private/tables/buckets/columns/type/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN type RESTRICT;