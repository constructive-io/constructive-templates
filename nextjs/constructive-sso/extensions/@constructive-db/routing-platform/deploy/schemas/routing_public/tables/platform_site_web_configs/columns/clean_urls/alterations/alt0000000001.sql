-- Deploy: schemas/routing_public/tables/platform_site_web_configs/columns/clean_urls/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/columns/clean_urls/column


COMMENT ON COLUMN routing_public.platform_site_web_configs.clean_urls IS 'Resolve extensionless paths to .html / index.html objects (NULL = gateway default)';