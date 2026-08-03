-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_ltree/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_ltree/column


COMMENT ON COLUMN routing_public.database_settings.enable_ltree IS 'Enable ltree hierarchical data type support in the GraphQL API';