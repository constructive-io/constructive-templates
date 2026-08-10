-- Deploy: schemas/myapp_storage_public/tables/app_buckets/columns/tags/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/tags/column


COMMENT ON COLUMN myapp_storage_public.app_buckets.tags IS E'Selector labels for capability resolution and grouping (e.g. uploads, variants, exports). A function''s required bucket key is matched against these plus type.';

