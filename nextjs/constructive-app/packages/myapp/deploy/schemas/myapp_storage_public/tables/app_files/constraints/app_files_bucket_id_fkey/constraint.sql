-- Deploy: schemas/myapp_storage_public/tables/app_files/constraints/app_files_bucket_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_bucket_id_fkey 
    FOREIGN KEY(bucket_id) 
    REFERENCES myapp_storage_public.app_buckets (id) 
    ON DELETE RESTRICT;

