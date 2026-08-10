-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN destination_bucket_id RESTRICT;


