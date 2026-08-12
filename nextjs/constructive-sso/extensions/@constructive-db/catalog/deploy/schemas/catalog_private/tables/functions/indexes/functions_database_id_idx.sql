-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/database_id/column


CREATE INDEX functions_database_id_idx ON catalog_private.functions (database_id);