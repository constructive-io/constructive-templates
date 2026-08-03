-- Deploy: schemas/routing_public/tables/platform_api_settings/columns/enable_i18n/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/columns/enable_i18n/column


COMMENT ON COLUMN routing_public.platform_api_settings.enable_i18n IS 'Override: enable internationalization plugin (NULL = inherit from database_settings)';