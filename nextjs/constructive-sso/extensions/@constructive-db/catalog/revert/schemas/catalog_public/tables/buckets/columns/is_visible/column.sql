-- Revert: schemas/catalog_public/tables/buckets/columns/is_visible/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN is_visible RESTRICT;