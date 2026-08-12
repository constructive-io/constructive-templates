-- Revert: schemas/myapp_storage_public/tables/app_files/columns/status/alterations/alt0000000002


ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN status DROP DEFAULT;


