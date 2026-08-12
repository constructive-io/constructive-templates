-- Deploy: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/updated_at/column


CREATE INDEX app_buckets_updated_at_idx ON myapp_storage_public.app_buckets ( updated_at );

