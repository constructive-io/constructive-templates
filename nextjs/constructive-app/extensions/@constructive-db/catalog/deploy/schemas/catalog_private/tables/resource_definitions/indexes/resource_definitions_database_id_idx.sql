-- Deploy: schemas/catalog_private/tables/resource_definitions/indexes/resource_definitions_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table
-- requires: schemas/catalog_private/tables/resource_definitions/columns/database_id/column


CREATE INDEX resource_definitions_database_id_idx ON catalog_private.resource_definitions (database_id);