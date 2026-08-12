-- Revert: schemas/catalog_public/tables/buckets/columns/database_id/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN database_id RESTRICT;