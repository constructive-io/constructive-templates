-- Deploy: schemas/catalog_public/tables/domains/indexes/domains_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/database_id/column


CREATE INDEX domains_database_id_idx ON catalog_public.domains (database_id);