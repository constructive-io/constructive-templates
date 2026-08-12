-- Revert: schemas/catalog_public/tables/buckets/columns/id/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN id RESTRICT;