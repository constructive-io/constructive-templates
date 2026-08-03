-- Deploy: schemas/routing_public/tables/platform_cors_settings/columns/api_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/columns/api_id/column


COMMENT ON COLUMN routing_public.platform_cors_settings.api_id IS 'Optional API surface for per-API override; NULL means scope-wide default';