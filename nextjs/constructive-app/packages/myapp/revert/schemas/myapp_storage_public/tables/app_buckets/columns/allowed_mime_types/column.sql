-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_mime_types/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN allowed_mime_types RESTRICT;


