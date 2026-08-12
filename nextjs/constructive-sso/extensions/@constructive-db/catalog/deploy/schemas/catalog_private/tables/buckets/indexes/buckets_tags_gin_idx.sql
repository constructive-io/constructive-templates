-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_tags_gin_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/tags/column


CREATE INDEX buckets_tags_gin_idx ON catalog_private.buckets USING gin (tags);