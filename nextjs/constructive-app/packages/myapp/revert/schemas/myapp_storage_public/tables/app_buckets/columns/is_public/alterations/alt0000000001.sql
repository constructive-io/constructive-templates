-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN is_public DROP NOT NULL;


