-- Deploy: schemas/catalog_public/tables/buckets/indexes/buckets_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table
-- requires: schemas/catalog_public/tables/buckets/columns/created_at/column


CREATE INDEX buckets_created_at_idx ON catalog_public.buckets (created_at);