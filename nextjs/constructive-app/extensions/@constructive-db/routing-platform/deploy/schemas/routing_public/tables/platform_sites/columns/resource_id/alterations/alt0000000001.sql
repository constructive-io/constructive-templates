-- Deploy: schemas/routing_public/tables/platform_sites/columns/resource_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/columns/resource_id/column


COMMENT ON COLUMN routing_public.platform_sites.resource_id IS 'Catalog resource/service that backs this site (SSR/app Service pinned to one concrete resource row; exactly one of bucket_id/resource_id/installation_id)';