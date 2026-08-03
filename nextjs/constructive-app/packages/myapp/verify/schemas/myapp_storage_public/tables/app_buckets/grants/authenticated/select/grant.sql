-- Verify: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_storage_public.app_buckets', 'SELECT', 'authenticated');


