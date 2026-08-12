-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_database_id_owner_scope_owner_key_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/key/column
-- requires: schemas/catalog_private/tables/buckets/columns/owner_key/column
-- requires: schemas/catalog_private/tables/buckets/columns/database_id/column
-- requires: schemas/catalog_private/tables/buckets/columns/owner_scope/column


CREATE UNIQUE INDEX buckets_database_id_owner_scope_owner_key_key_idx ON catalog_private.buckets (database_id, owner_scope, owner_key, key) WHERE buckets.owner_key IS NOT NULL;