-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/physical_name/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN physical_name RESTRICT;


