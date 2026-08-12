-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/allow_custom_keys/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN allow_custom_keys boolean;

