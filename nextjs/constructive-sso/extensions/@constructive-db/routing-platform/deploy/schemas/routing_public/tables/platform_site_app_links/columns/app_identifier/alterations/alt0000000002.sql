-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/app_identifier/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/columns/app_identifier/column


COMMENT ON COLUMN routing_public.platform_site_app_links.app_identifier IS 'App identifier: iOS bundle id or Android package name';