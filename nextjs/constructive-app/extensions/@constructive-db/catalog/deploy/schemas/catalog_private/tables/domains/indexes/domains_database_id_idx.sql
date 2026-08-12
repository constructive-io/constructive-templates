-- Deploy: schemas/catalog_private/tables/domains/indexes/domains_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/database_id/column


CREATE INDEX domains_database_id_idx ON catalog_private.domains (database_id);