-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/allow_custom_keys/alterations/alt0000000002


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN allow_custom_keys DROP DEFAULT;


