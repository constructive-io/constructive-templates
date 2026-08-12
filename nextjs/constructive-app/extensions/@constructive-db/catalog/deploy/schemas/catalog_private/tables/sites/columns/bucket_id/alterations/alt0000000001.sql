-- Deploy: schemas/catalog_private/tables/sites/columns/bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/columns/bucket_id/column


COMMENT ON COLUMN catalog_private.sites.bucket_id IS 'Bucket backing propagated from the source row (resolver dereference key)';