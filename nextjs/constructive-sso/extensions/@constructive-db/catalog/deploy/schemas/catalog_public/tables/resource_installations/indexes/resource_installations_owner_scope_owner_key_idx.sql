-- Deploy: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table
-- requires: schemas/catalog_public/tables/resource_installations/columns/owner_key/column
-- requires: schemas/catalog_public/tables/resource_installations/columns/owner_scope/column


CREATE INDEX resource_installations_owner_scope_owner_key_idx ON catalog_public.resource_installations (owner_scope, owner_key);