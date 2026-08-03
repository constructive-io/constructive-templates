-- Revert: schemas/catalog_public/tables/buckets/columns/type/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN type RESTRICT;