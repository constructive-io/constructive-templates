-- Deploy: schemas/routing_public/tables/api_settings/columns/enable_aggregates/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/enable_aggregates/column


COMMENT ON COLUMN routing_public.api_settings.enable_aggregates IS 'Override: enable aggregate queries (NULL = inherit from database_settings)';