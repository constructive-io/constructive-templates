-- Deploy: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/insert/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


GRANT INSERT ON myapp_storage_public.app_buckets TO authenticated;

