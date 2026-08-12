-- Deploy: schemas/catalog_private/tables/namespaces/indexes/namespaces_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/created_at/column


CREATE INDEX namespaces_created_at_idx ON catalog_private.namespaces (created_at);