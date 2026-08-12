-- Deploy: schemas/routing_public/tables/platform_api_settings/columns/enable_bulk/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/columns/enable_bulk/column


COMMENT ON COLUMN routing_public.platform_api_settings.enable_bulk IS 'Override: enable bulk mutations (NULL = inherit from database_settings)';