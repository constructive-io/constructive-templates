-- Deploy: schemas/routing_public/tables/site_metadata/columns/robots/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/columns/robots/column


COMMENT ON COLUMN routing_public.site_metadata.robots IS 'robots meta directive (e.g. index,follow / noindex,nofollow)';