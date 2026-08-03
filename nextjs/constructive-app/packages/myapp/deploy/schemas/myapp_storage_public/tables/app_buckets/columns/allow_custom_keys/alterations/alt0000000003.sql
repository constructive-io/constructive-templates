-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/allow_custom_keys/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/allow_custom_keys/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.allow_custom_keys IS E'When true, clients can provide custom S3 keys (e.g. reports/2024/Q1.pdf). When false (default), S3 key = content hash (automatic dedup). contentHash always required for integrity.';

