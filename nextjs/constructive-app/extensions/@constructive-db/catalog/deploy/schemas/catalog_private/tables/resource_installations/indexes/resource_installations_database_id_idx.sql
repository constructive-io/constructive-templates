-- Deploy: schemas/catalog_private/tables/resource_installations/indexes/resource_installations_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/database_id/column


CREATE INDEX resource_installations_database_id_idx ON catalog_private.resource_installations (database_id);