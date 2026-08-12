-- Deploy: schemas/catalog_public/tables/resources/indexes/resources_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/owner_key/column
-- requires: schemas/catalog_public/tables/resources/columns/owner_scope/column


CREATE INDEX resources_owner_scope_owner_key_idx ON catalog_public.resources (owner_scope, owner_key);