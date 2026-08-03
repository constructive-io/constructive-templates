-- Revert: schemas/catalog_public/tables/buckets/columns/key/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN key DROP NOT NULL;