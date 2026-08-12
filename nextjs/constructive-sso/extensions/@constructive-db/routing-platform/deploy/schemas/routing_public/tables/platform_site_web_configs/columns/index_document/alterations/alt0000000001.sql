-- Deploy: schemas/routing_public/tables/platform_site_web_configs/columns/index_document/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/columns/index_document/column


COMMENT ON COLUMN routing_public.platform_site_web_configs.index_document IS 'Default object served for directory-style requests (e.g. index.html; NULL = gateway default)';