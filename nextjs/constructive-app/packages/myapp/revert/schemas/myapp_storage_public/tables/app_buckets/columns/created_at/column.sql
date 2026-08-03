-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/created_at/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN created_at RESTRICT;


