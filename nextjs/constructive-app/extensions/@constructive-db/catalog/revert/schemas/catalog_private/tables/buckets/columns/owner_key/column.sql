-- Revert: schemas/catalog_private/tables/buckets/columns/owner_key/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN owner_key RESTRICT;