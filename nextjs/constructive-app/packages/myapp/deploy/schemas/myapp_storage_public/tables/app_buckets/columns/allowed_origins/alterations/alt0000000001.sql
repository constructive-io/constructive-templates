-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_origins/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/allowed_origins/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.allowed_origins IS E'Per-bucket CORS allowed origins override (NULL = inherit from storage_module/plugin defaults). Use ARRAY[''*''] for open/CDN mode.';

