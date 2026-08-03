-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/type/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/type/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.type IS E'Bucket CDN access type: public (CDN-served), private (presigned GET), temp (staging uploads)';

