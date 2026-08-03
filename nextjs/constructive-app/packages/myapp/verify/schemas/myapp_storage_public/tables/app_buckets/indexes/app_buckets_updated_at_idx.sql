-- Verify: schemas/myapp_storage_public/tables/app_buckets/indexes/app_buckets_updated_at_idx


SELECT verify_index('myapp_storage_public.app_buckets', 'app_buckets_updated_at_idx');


