-- Revert: schemas/catalog_public/tables/buckets/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN created_at DROP DEFAULT;