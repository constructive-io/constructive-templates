-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/owner_key/column
-- requires: schemas/catalog_private/tables/buckets/columns/owner_scope/column


CREATE INDEX buckets_owner_scope_owner_key_idx ON catalog_private.buckets (owner_scope, owner_key);