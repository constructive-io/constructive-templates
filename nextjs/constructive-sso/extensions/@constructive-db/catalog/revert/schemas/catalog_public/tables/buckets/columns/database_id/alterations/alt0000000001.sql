-- Revert: schemas/catalog_public/tables/buckets/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN database_id DROP NOT NULL;