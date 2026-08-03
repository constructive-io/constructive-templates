-- Verify: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/insert/grant


SELECT verify_table_grant('myapp_storage_public.app_buckets', 'INSERT', 'authenticated');


