-- Deploy: schemas/routing_public/tables/database_settings/columns/options/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/options/column


COMMENT ON COLUMN routing_public.database_settings.options IS 'Extensible JSON for additional settings that do not have dedicated columns';