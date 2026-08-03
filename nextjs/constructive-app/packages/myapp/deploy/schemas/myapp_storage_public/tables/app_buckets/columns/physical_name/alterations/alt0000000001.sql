-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/physical_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/physical_name/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.physical_name IS E'Physical S3/MinIO bucket name recorded at provision time (NULL until the physical bucket exists)';

