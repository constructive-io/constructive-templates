-- Deploy: schemas/routing_public/tables/site_modules/columns/database_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/columns/database_id/column


COMMENT ON COLUMN routing_public.site_modules.database_id IS 'Database that owns this resource (database-scoped isolation)';