-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/slug/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/slug/column


COMMENT ON COLUMN routing_public.platform_site_deep_links.slug IS 'Link name unique per site; addressed at the deep-link path prefix (e.g. /l/<slug>)';