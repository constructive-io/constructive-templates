-- Deploy: schemas/catalog_public/tables/buckets/columns/physical_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/columns/physical_name/column


COMMENT ON COLUMN catalog_public.buckets.physical_name IS 'Physical S3/MinIO bucket name propagated from the source row (NULL until the physical bucket exists)';