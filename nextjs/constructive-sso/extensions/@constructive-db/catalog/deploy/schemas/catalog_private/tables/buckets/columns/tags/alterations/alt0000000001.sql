-- Deploy: schemas/catalog_private/tables/buckets/columns/tags/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/columns/tags/column


COMMENT ON COLUMN catalog_private.buckets.tags IS 'Selector labels propagated from the source row (see the buckets table''s tags)';