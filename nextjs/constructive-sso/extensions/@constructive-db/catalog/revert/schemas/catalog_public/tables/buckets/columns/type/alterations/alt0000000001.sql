-- Revert: schemas/catalog_public/tables/buckets/columns/type/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN type DROP NOT NULL;