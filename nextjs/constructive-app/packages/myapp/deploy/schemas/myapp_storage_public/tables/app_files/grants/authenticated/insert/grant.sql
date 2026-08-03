-- Deploy: schemas/myapp_storage_public/tables/app_files/grants/authenticated/insert/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


GRANT INSERT ON myapp_storage_public.app_files TO authenticated;

