-- Deploy: schemas/catalog_private/tables/resource_installations/indexes/resource_installations_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/owner_key/column
-- requires: schemas/catalog_private/tables/resource_installations/columns/owner_scope/column


CREATE INDEX resource_installations_owner_scope_owner_key_idx ON catalog_private.resource_installations (owner_scope, owner_key);