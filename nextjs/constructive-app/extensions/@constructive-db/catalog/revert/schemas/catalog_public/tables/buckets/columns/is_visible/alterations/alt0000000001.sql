-- Revert: schemas/catalog_public/tables/buckets/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN is_visible DROP NOT NULL;