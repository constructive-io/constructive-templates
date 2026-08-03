-- Deploy: schemas/catalog_public/tables/buckets/indexes/buckets_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table
-- requires: schemas/catalog_public/tables/buckets/columns/is_visible/column


CREATE INDEX buckets_is_visible_idx ON catalog_public.buckets (is_visible);