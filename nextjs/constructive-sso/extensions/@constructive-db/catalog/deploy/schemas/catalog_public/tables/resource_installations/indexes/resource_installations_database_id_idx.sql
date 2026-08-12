-- Deploy: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table
-- requires: schemas/catalog_public/tables/resource_installations/columns/database_id/column


CREATE INDEX resource_installations_database_id_idx ON catalog_public.resource_installations (database_id);