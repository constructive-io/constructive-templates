-- Revert: schemas/catalog_private/tables/buckets/columns/id/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN id RESTRICT;