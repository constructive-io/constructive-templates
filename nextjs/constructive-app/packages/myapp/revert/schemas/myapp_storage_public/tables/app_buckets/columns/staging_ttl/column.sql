-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/staging_ttl/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN staging_ttl RESTRICT;


