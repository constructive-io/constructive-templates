-- Deploy: schemas/catalog_private/tables/buckets/columns/type/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/columns/type/column


COMMENT ON COLUMN catalog_private.buckets.type IS 'Bucket type (public/private) propagated from the source row';