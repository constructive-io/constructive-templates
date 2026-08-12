-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_aggregates/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_aggregates/column


COMMENT ON COLUMN routing_public.database_settings.enable_aggregates IS 'Enable aggregate queries (sum, avg, min, max, etc.) in the GraphQL API';