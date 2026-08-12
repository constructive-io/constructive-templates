-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/is_visible/column


CREATE INDEX buckets_is_visible_idx ON catalog_private.buckets (is_visible);