-- Revert: schemas/catalog_public/tables/buckets/columns/physical_name/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN physical_name RESTRICT;