-- Revert: schemas/myapp_storage_public/tables/app_files/columns/mime_type/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN mime_type RESTRICT;


