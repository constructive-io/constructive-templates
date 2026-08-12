-- Deploy: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_is_public_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/is_public/column


CREATE INDEX app_buckets_is_public_idx ON myapp_storage_public.app_buckets USING BTREE ( is_public );

