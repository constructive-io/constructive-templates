-- Revert: schemas/catalog_public/tables/buckets/columns/created_at/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN created_at RESTRICT;