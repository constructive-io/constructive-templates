-- Revert: schemas/catalog_public/tables/buckets/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN owner_scope DROP NOT NULL;