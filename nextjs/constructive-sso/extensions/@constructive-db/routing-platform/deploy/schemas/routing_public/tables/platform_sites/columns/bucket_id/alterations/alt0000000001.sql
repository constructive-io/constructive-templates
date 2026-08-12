-- Deploy: schemas/routing_public/tables/platform_sites/columns/bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/columns/bucket_id/column


COMMENT ON COLUMN routing_public.platform_sites.bucket_id IS 'Catalog bucket that backs this site (static content store; exactly one of bucket_id/resource_id)';