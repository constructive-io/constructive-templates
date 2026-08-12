-- Deploy: schemas/routing_public/tables/database_settings/columns/database_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/database_id/column


COMMENT ON COLUMN routing_public.database_settings.database_id IS 'Database that owns this resource (database-scoped isolation)';