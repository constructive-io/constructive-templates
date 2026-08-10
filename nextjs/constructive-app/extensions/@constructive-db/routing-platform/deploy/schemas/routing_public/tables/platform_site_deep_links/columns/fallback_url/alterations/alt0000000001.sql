-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/fallback_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/fallback_url/column


COMMENT ON COLUMN routing_public.platform_site_deep_links.fallback_url IS 'Absolute external fallback URL for app-only targets (no web equivalent on this site)';