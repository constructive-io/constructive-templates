-- Deploy: schemas/catalog_private/tables/buckets/columns/key/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/columns/key/column


COMMENT ON COLUMN catalog_private.buckets.key IS 'Owner-local logical bucket key propagated from the source row';