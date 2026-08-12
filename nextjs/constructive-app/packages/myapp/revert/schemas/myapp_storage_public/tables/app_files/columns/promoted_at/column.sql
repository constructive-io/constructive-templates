-- Revert: schemas/myapp_storage_public/tables/app_files/columns/promoted_at/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN promoted_at RESTRICT;


