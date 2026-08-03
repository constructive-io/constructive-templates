-- Deploy: schemas/catalog_public/tables/resources/indexes/resources_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/database_id/column


CREATE INDEX resources_database_id_idx ON catalog_public.resources (database_id);