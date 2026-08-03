-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.is_public IS E'Whether bucket contents are publicly readable. Set to true when type is public.';

