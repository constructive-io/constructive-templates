-- Deploy: schemas/catalog_private/tables/apis/indexes/apis_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/catalog_private/tables/apis/columns/database_id/column


CREATE INDEX apis_database_id_idx ON catalog_private.apis (database_id);