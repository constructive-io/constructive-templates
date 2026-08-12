-- Deploy: schemas/catalog_private/tables/resources/indexes/resources_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/catalog_private/tables/resources/columns/database_id/column


CREATE INDEX resources_database_id_idx ON catalog_private.resources (database_id);