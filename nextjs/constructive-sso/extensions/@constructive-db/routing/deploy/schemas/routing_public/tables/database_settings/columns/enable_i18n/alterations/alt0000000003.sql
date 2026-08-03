-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_i18n/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_i18n/column


COMMENT ON COLUMN routing_public.database_settings.enable_i18n IS 'Enable internationalization plugin (localeStrings field, translation table discovery) in the GraphQL API';