-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/updated_at/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN updated_at RESTRICT;


