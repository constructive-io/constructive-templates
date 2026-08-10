-- Deploy: schemas/catalog_private/tables/domains/indexes/domains_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/created_at/column


CREATE INDEX domains_created_at_idx ON catalog_private.domains (created_at);