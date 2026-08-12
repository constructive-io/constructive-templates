-- Deploy: schemas/catalog_private/tables/bindings/indexes/bindings_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/updated_at/column


CREATE INDEX bindings_updated_at_idx ON catalog_private.bindings (updated_at);