-- Deploy: schemas/routing_public/tables/platform_site_themes/columns/name/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/columns/name/column


COMMENT ON COLUMN routing_public.platform_site_themes.name IS 'Owner-local theme name (a site may hold multiple named themes)';