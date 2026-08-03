-- Deploy: schemas/catalog_public/tables/resource_definitions/indexes/resource_definitions_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table
-- requires: schemas/catalog_public/tables/resource_definitions/columns/database_id/column


CREATE INDEX resource_definitions_database_id_idx ON catalog_public.resource_definitions (database_id);