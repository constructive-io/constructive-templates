-- Deploy: schemas/catalog_private/tables/namespaces/indexes/namespaces_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/database_id/column


CREATE INDEX namespaces_database_id_idx ON catalog_private.namespaces (database_id);