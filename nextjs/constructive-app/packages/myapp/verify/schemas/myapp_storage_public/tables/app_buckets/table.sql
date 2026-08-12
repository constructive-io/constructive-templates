-- Verify: schemas/myapp_storage_public/tables/app_buckets/table


SELECT assert_table('myapp_storage_public.app_buckets'::regclass, false, NULL);


