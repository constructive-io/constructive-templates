-- Deploy: schemas/routing_public/tables/platform_api_settings/columns/enable_ltree/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/columns/enable_ltree/column


COMMENT ON COLUMN routing_public.platform_api_settings.enable_ltree IS 'Override: enable ltree hierarchical data type (NULL = inherit from database_settings)';