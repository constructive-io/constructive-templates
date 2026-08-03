-- Revert: schemas/myapp_storage_public/tables/app_files/columns/mime_type/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN mime_type DROP NOT NULL;


