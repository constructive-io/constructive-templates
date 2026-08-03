-- Deploy: schemas/catalog_public/tables/domains/indexes/domains_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/created_at/column


CREATE INDEX domains_created_at_idx ON catalog_public.domains (created_at);