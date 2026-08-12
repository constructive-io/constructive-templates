-- Deploy: schemas/catalog_private/tables/namespaces/indexes/namespaces_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/owner_key/column
-- requires: schemas/catalog_private/tables/namespaces/columns/owner_scope/column


CREATE INDEX namespaces_owner_scope_owner_key_idx ON catalog_private.namespaces (owner_scope, owner_key);