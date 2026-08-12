-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/description/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/description/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.description IS E'Human-readable description of the bucket purpose';

