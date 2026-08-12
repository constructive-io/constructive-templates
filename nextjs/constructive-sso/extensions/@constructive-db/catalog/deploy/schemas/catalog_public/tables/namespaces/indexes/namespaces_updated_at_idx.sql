-- Deploy: schemas/catalog_public/tables/namespaces/indexes/namespaces_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/updated_at/column


CREATE INDEX namespaces_updated_at_idx ON catalog_public.namespaces (updated_at);