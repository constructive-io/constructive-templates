-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_mime_types/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN allowed_mime_types text[];

