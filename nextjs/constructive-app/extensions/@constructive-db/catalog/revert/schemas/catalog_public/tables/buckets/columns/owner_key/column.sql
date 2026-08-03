-- Revert: schemas/catalog_public/tables/buckets/columns/owner_key/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN owner_key RESTRICT;