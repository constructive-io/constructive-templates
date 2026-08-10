-- Deploy: schemas/catalog_private/tables/buckets/columns/physical_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/columns/physical_name/column


COMMENT ON COLUMN catalog_private.buckets.physical_name IS 'Physical S3/MinIO bucket name propagated from the source row (NULL until the physical bucket exists)';