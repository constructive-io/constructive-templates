-- Deploy: schemas/catalog_private/tables/domains/indexes/domains_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/updated_at/column


CREATE INDEX domains_updated_at_idx ON catalog_private.domains (updated_at);