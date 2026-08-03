-- Deploy: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/created_at/column


CREATE INDEX app_buckets_created_at_idx ON myapp_storage_public.app_buckets ( created_at );

