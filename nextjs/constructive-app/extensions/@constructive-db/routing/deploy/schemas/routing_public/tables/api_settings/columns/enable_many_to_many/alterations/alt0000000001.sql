-- Deploy: schemas/routing_public/tables/api_settings/columns/enable_many_to_many/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/enable_many_to_many/column


COMMENT ON COLUMN routing_public.api_settings.enable_many_to_many IS 'Override: enable many-to-many relationships (NULL = inherit from database_settings)';