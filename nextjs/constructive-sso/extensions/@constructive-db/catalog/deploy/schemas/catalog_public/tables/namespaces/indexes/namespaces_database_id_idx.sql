-- Deploy: schemas/catalog_public/tables/namespaces/indexes/namespaces_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/database_id/column


CREATE INDEX namespaces_database_id_idx ON catalog_public.namespaces (database_id);