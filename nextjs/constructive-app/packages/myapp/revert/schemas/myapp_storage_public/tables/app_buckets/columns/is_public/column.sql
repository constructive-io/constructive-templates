-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN is_public RESTRICT;


