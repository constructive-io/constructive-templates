-- Revert: schemas/myapp_storage_public/tables/app_files/columns/updated_at/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN updated_at RESTRICT;


