-- Deploy: schemas/catalog_private/tables/namespaces/indexes/namespaces_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/updated_at/column


CREATE INDEX namespaces_updated_at_idx ON catalog_private.namespaces (updated_at);