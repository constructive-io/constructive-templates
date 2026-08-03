-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/id/alterations/alt0000000002


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN id DROP DEFAULT;


