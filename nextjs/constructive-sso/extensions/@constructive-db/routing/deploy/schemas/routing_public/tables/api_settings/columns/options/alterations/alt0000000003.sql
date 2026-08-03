-- Deploy: schemas/routing_public/tables/api_settings/columns/options/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/options/column


COMMENT ON COLUMN routing_public.api_settings.options IS 'Extensible JSON for additional per-API settings that do not have dedicated columns';