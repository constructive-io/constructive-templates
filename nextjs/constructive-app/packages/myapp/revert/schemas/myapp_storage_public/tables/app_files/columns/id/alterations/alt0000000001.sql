-- Revert: schemas/myapp_storage_public/tables/app_files/columns/id/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN id DROP NOT NULL;


