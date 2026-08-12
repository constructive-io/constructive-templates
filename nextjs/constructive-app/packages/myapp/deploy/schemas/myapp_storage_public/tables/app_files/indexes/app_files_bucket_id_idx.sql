-- Deploy: schemas/myapp_storage_public/tables/app_files/indexes/app_files_bucket_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/bucket_id/column


CREATE INDEX app_files_bucket_id_idx ON myapp_storage_public.app_files USING BTREE ( bucket_id );

