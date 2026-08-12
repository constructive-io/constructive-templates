-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_origins/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN allowed_origins RESTRICT;


