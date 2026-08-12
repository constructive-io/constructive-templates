-- Deploy: schemas/routing_public/tables/platform_site_error_pages/columns/object_path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/columns/object_path/column


COMMENT ON COLUMN routing_public.platform_site_error_pages.object_path IS 'Bucket object served for this status code (original status is preserved)';