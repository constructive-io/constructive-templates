-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_mime_types/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_mime_types/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.allowed_mime_types IS E'Whitelist of allowed MIME types for files in this bucket (NULL = all allowed, enforcement deferred)';

