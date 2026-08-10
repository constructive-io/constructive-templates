-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/tags/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN tags RESTRICT;


