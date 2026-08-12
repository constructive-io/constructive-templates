-- Deploy: schemas/catalog_public/tables/apps/indexes/apps_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/database_id/column


CREATE INDEX apps_database_id_idx ON catalog_public.apps (database_id);