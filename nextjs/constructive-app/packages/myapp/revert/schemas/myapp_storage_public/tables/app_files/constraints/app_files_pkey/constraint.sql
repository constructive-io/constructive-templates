-- Revert: schemas/myapp_storage_public/tables/app_files/constraints/app_files_pkey/constraint


ALTER TABLE myapp_storage_public.app_files 
  DROP CONSTRAINT app_files_pkey;


