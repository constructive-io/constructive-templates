-- Deploy: schemas/routing_public/tables/platform_pages/columns/slug/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/columns/slug/column


COMMENT ON COLUMN routing_public.platform_pages.slug IS 'Page slug (unique per site)';