-- Revert: schemas/myapp_storage_public/tables/app_files/columns/id/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN id RESTRICT;


