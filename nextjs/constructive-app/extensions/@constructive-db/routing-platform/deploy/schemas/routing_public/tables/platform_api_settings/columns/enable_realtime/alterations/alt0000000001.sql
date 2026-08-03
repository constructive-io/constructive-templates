-- Deploy: schemas/routing_public/tables/platform_api_settings/columns/enable_realtime/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/columns/enable_realtime/column


COMMENT ON COLUMN routing_public.platform_api_settings.enable_realtime IS 'Override: enable realtime subscriptions (NULL = inherit from database_settings)';