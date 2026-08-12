-- Deploy: schemas/myapp_storage_public/tables/app_files/constraints/app_files_bucket_id_key_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_bucket_id_key_key 
    UNIQUE (bucket_id, key);

