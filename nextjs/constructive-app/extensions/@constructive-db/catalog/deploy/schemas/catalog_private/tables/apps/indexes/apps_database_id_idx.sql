-- Deploy: schemas/catalog_private/tables/apps/indexes/apps_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/database_id/column


CREATE INDEX apps_database_id_idx ON catalog_private.apps (database_id);