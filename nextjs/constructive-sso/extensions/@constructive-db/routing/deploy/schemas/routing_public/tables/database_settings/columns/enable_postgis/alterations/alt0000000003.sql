-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_postgis/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_postgis/column


COMMENT ON COLUMN routing_public.database_settings.enable_postgis IS 'Enable PostGIS spatial types and operators in the GraphQL API';