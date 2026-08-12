-- Revert: schemas/catalog_public/tables/buckets/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN id DROP NOT NULL;