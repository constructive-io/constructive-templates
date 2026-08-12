-- Revert: schemas/catalog_private/tables/buckets/columns/tags/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN tags RESTRICT;