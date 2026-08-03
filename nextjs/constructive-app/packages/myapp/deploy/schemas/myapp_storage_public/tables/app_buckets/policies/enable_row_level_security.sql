-- Deploy: schemas/myapp_storage_public/tables/app_buckets/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_buckets 
  ENABLE ROW LEVEL SECURITY;

