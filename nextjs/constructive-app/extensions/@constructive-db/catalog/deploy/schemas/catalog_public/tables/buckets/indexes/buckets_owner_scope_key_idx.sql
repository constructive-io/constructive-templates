-- Deploy: schemas/catalog_public/tables/buckets/indexes/buckets_owner_scope_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table
-- requires: schemas/catalog_public/tables/buckets/columns/key/column
-- requires: schemas/catalog_public/tables/buckets/columns/owner_key/column
-- requires: schemas/catalog_public/tables/buckets/columns/owner_scope/column


CREATE UNIQUE INDEX buckets_owner_scope_key_idx ON catalog_public.buckets (owner_scope, key) WHERE buckets.owner_key IS NULL;