-- Revert: schemas/catalog_private/tables/buckets/columns/created_at/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN created_at RESTRICT;