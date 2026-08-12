-- Deploy: schemas/routing_public/tables/platform_api_settings/columns/enable_connection_filter/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/columns/enable_connection_filter/column


COMMENT ON COLUMN routing_public.platform_api_settings.enable_connection_filter IS 'Override: enable connection filter (NULL = inherit from database_settings)';