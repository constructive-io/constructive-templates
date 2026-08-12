-- Verify: schemas/myapp_storage_public/tables/app_buckets/triggers/app_buckets_staging_guard_tg


SELECT assert_trigger('myapp_storage_public.app_buckets'::regclass, 'app_buckets_staging_guard_tg', 'myapp_storage_private.app_buckets_staging_guard'::regproc, 23);


