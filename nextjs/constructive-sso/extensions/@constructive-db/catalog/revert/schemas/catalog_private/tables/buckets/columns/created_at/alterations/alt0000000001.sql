-- Revert: schemas/catalog_private/tables/buckets/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN created_at DROP DEFAULT;