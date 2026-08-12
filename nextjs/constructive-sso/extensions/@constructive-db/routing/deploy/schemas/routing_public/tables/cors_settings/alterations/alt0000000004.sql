-- Deploy: schemas/routing_public/tables/cors_settings/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table


COMMENT ON TABLE routing_public.cors_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Scope-wide and per-API CORS origin configuration; NULL api_id means scope-wide default';