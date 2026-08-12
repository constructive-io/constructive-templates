-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/created_at/column


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN created_at SET DEFAULT now();

