-- Revert: schemas/myapp_storage_public/tables/app_files/columns/tags/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN tags RESTRICT;


