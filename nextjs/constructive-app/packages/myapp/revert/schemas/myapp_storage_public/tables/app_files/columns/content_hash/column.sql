-- Revert: schemas/myapp_storage_public/tables/app_files/columns/content_hash/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN content_hash RESTRICT;


