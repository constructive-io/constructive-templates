-- Deploy: schemas/routing_public/tables/platform_cors_settings/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table


COMMENT ON TABLE routing_public.platform_cors_settings IS '@scope platform
@has_guard
@scopeTier global
Scope-wide and per-API CORS origin configuration; NULL api_id means scope-wide default';