-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/staging_ttl/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/staging_ttl/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.staging_ttl IS E'For a temp bucket, how long an unpromoted staged file survives before it is eligible for expiry. NULL on non-temp buckets; required on temp buckets.';

