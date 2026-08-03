-- Deploy: schemas/catalog_public/tables/sites/indexes/sites_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/database_id/column


CREATE INDEX sites_database_id_idx ON catalog_public.sites (database_id);