-- Deploy: schemas/myapp_storage_public/tables/app_files/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


ALTER TABLE myapp_storage_public.app_files 
  DISABLE ROW LEVEL SECURITY;

