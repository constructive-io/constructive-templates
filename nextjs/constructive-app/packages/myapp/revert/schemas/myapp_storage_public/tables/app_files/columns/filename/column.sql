-- Revert: schemas/myapp_storage_public/tables/app_files/columns/filename/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN filename RESTRICT;


