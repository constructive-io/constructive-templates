-- Deploy: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_destination_bucket_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/column


CREATE UNIQUE INDEX app_buckets_destination_bucket_id_idx ON myapp_storage_public.app_buckets USING BTREE ( destination_bucket_id );

