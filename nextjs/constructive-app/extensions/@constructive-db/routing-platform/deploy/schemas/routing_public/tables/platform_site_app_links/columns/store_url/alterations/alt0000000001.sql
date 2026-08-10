-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/store_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/columns/store_url/column


COMMENT ON COLUMN routing_public.platform_site_app_links.store_url IS 'App/Play store URL for this app (used by install banners and fallbacks)';