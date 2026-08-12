-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/owner_key/column
-- requires: schemas/catalog_private/tables/functions/columns/owner_scope/column


CREATE INDEX functions_owner_scope_owner_key_idx ON catalog_private.functions (owner_scope, owner_key);