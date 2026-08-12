-- Deploy: schemas/routing_public/tables/platform_api_settings/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/table


COMMENT ON TABLE routing_public.platform_api_settings IS '@scope platform
@scopeTier global
Per-API feature flag overrides; NULL columns inherit from database_settings';