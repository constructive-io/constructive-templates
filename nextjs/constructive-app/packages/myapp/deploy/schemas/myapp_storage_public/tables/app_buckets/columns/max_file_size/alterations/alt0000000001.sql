-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/max_file_size/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/max_file_size/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.max_file_size IS E'Maximum file size in bytes allowed in this bucket (NULL = no limit, enforcement deferred)';

