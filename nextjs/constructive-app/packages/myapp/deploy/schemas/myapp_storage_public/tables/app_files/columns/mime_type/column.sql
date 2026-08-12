-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/mime_type/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN mime_type text;

