-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN created_at DROP DEFAULT;


