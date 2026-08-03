-- Revert: schemas/catalog_public/tables/buckets/columns/key/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN key RESTRICT;