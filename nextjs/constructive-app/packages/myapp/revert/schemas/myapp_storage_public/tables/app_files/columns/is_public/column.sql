-- Revert: schemas/myapp_storage_public/tables/app_files/columns/is_public/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN is_public RESTRICT;


