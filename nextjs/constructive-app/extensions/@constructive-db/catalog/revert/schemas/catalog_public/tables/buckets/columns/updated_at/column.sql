-- Revert: schemas/catalog_public/tables/buckets/columns/updated_at/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN updated_at RESTRICT;