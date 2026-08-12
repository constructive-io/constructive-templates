-- Deploy: schemas/catalog_private/tables/resources/indexes/resources_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/catalog_private/tables/resources/columns/owner_key/column
-- requires: schemas/catalog_private/tables/resources/columns/owner_scope/column


CREATE INDEX resources_owner_scope_owner_key_idx ON catalog_private.resources (owner_scope, owner_key);