-- Deploy: schemas/catalog_private/tables/bindings/indexes/bindings_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/created_at/column


CREATE INDEX bindings_created_at_idx ON catalog_private.bindings (created_at);