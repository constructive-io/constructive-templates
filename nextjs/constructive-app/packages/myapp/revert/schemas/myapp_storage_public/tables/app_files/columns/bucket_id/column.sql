-- Revert: schemas/myapp_storage_public/tables/app_files/columns/bucket_id/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN bucket_id RESTRICT;


