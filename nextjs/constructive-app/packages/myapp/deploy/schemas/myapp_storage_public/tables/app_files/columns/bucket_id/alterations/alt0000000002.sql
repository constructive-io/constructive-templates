-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/bucket_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/bucket_id/column


COMMENT ON COLUMN myapp_storage_public.app_files.bucket_id IS E'Bucket this file belongs to. Determines owner_id and is_public via inheritance trigger.';

