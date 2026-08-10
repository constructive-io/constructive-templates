-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.destination_bucket_id IS E'For a temp bucket, the permanent bucket its uploads are promoted into. NULL on non-temp buckets; required on temp buckets.';

