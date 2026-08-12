-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/allow_custom_keys/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN allow_custom_keys RESTRICT;


