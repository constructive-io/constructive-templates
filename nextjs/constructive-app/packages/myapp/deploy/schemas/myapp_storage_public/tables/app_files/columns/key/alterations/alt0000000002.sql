-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/key/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/key/column


COMMENT ON COLUMN myapp_storage_public.app_files.key IS E'S3 object key for this file, unique within its bucket';

