-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/column


COMMENT ON COLUMN routing_public.database_settings.enable_many_to_many IS 'Enable many-to-many relationship queries in the GraphQL API';