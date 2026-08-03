-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/key/column


ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN key SET NOT NULL;

