-- Revert: schemas/myapp_storage_public/tables/app_files/columns/status/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN status RESTRICT;


