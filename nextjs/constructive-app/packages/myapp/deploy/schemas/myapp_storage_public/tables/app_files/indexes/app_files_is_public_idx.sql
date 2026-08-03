-- Deploy: schemas/myapp_storage_public/tables/app_files/indexes/app_files_is_public_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/is_public/column


CREATE INDEX app_files_is_public_idx ON myapp_storage_public.app_files USING BTREE ( is_public );

