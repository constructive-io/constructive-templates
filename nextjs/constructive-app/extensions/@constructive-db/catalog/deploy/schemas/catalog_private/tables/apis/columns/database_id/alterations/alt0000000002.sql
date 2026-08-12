-- Deploy: schemas/catalog_private/tables/apis/columns/database_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/columns/database_id/column


COMMENT ON COLUMN catalog_private.apis.database_id IS 'Database that owns the source row: the tenant database for database-scope rows, the hosting database otherwise';