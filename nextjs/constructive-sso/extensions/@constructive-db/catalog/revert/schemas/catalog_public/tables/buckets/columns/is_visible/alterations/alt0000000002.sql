-- Revert: schemas/catalog_public/tables/buckets/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN is_visible DROP DEFAULT;