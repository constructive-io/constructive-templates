-- Revert: schemas/catalog_private/tables/buckets/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN updated_at DROP DEFAULT;