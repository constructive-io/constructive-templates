-- Revert: schemas/catalog_public/tables/buckets/columns/id/alterations/alt0000000002


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN id DROP DEFAULT;