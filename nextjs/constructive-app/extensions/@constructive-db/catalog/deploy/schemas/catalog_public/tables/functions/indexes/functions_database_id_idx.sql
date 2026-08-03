-- Deploy: schemas/catalog_public/tables/functions/indexes/functions_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/database_id/column


CREATE INDEX functions_database_id_idx ON catalog_public.functions (database_id);