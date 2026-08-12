-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/key/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/key/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.key IS E'Unique bucket identifier used in S3 key paths (e.g. avatars, documents, temp)';

