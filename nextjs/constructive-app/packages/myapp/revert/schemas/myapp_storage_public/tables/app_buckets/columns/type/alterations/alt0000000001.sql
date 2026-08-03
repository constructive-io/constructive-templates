-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/type/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN type DROP NOT NULL;


