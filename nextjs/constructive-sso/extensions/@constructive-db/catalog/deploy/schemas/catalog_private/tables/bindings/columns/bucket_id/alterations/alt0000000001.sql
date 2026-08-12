-- Deploy: schemas/catalog_private/tables/bindings/columns/bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/columns/bucket_id/column


COMMENT ON COLUMN catalog_private.bindings.bucket_id IS 'Bucket the binding targets, propagated from the source row';