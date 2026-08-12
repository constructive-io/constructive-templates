-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/id/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN id RESTRICT;


