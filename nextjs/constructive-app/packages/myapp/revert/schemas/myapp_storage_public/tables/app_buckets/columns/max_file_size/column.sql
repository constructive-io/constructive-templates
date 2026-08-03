-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/max_file_size/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN max_file_size RESTRICT;


