-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/column


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN is_public SET DEFAULT false;

