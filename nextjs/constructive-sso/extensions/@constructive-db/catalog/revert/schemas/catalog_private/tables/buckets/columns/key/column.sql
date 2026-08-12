-- Revert: schemas/catalog_private/tables/buckets/columns/key/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN key RESTRICT;