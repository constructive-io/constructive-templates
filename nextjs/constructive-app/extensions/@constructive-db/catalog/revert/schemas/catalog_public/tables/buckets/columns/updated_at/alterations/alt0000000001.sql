-- Revert: schemas/catalog_public/tables/buckets/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN updated_at DROP DEFAULT;