-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_connection_filter/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_connection_filter/column


COMMENT ON COLUMN routing_public.database_settings.enable_connection_filter IS 'Enable connection filter (where argument) in the GraphQL API';