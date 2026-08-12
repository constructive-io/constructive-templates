-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/robots/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/robots/column


COMMENT ON COLUMN routing_public.platform_site_metadata.robots IS 'robots meta directive (e.g. index,follow / noindex,nofollow)';