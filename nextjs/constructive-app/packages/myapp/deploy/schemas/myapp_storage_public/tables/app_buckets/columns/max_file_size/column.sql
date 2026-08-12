-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/max_file_size/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN max_file_size bigint;

