-- Deploy: schemas/catalog_private/tables/domains/indexes/domains_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/owner_key/column
-- requires: schemas/catalog_private/tables/domains/columns/owner_scope/column


CREATE INDEX domains_owner_scope_owner_key_idx ON catalog_private.domains (owner_scope, owner_key);