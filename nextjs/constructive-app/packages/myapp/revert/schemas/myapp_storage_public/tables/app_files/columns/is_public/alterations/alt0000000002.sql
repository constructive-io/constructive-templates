-- Revert: schemas/myapp_storage_public/tables/app_files/columns/is_public/alterations/alt0000000002


ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN is_public DROP DEFAULT;


