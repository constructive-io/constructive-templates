-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/updated_at/column


CREATE INDEX buckets_updated_at_idx ON catalog_private.buckets (updated_at);