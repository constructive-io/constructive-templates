-- Deploy: schemas/routing_public/tables/api_settings/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


COMMENT ON TABLE routing_public.api_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Per-API feature flag overrides; NULL columns inherit from database_settings';