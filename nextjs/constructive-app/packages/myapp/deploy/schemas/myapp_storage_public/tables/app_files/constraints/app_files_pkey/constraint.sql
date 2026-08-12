-- Deploy: schemas/myapp_storage_public/tables/app_files/constraints/app_files_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_pkey PRIMARY KEY (id);

