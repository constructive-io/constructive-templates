-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/description/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN description RESTRICT;


