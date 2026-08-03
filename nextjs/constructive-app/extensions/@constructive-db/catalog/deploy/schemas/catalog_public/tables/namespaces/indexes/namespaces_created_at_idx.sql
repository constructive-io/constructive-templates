-- Deploy: schemas/catalog_public/tables/namespaces/indexes/namespaces_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/created_at/column


CREATE INDEX namespaces_created_at_idx ON catalog_public.namespaces (created_at);