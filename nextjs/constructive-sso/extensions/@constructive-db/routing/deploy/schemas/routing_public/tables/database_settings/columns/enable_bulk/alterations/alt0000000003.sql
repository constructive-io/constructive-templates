-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_bulk/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_bulk/column


COMMENT ON COLUMN routing_public.database_settings.enable_bulk IS 'Enable bulk mutation operations (insert, upsert, update, delete) in the GraphQL API';