-- Deploy: schemas/catalog_public/tables/apis/indexes/apis_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/database_id/column


CREATE INDEX apis_database_id_idx ON catalog_public.apis (database_id);