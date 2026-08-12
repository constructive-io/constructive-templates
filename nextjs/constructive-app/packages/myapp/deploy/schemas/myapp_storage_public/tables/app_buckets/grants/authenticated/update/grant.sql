-- Deploy: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/update/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


GRANT UPDATE ON myapp_storage_public.app_buckets TO authenticated;

