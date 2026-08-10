-- Verify: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_storage_public.app_buckets'::regclass, 'authenticated', 'SELECT', NULL, true);


