-- Deploy: schemas/catalog_private/tables/bindings/indexes/bindings_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/owner_key/column
-- requires: schemas/catalog_private/tables/bindings/columns/owner_scope/column


CREATE INDEX bindings_owner_scope_owner_key_idx ON catalog_private.bindings (owner_scope, owner_key);