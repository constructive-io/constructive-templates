-- Deploy: schemas/catalog_private/tables/resource_definitions/indexes/resource_definitions_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table
-- requires: schemas/catalog_private/tables/resource_definitions/columns/owner_key/column
-- requires: schemas/catalog_private/tables/resource_definitions/columns/owner_scope/column


CREATE INDEX resource_definitions_owner_scope_owner_key_idx ON catalog_private.resource_definitions (owner_scope, owner_key);