-- Verify: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_storage_public.app_buckets'::regclass, 'authenticated', 'UPDATE', NULL, true);


