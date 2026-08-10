-- Verify: schemas/myapp_storage_public/tables/app_buckets/triggers/app_buckets_immutable_fields_tg


SELECT assert_trigger('myapp_storage_public.app_buckets'::regclass, 'app_buckets_immutable_fields_tg', 'myapp_app_private.app_buckets_immutable_fields'::regproc, 19);


