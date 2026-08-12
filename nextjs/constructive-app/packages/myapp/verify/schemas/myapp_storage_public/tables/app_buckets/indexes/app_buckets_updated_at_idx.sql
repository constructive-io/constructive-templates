-- Verify: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_updated_at_idx


SELECT assert_index('myapp_storage_public.app_buckets_updated_at_idx'::regclass, 'myapp_storage_public.app_buckets'::regclass, false);


