-- Verify: schemas/myapp_store_public/views/app_internal_secrets/grants/authenticated/SELECT/grant


SELECT assert_table_grant('myapp_store_public.app_internal_secrets'::regclass, 'authenticated', 'SELECT', NULL, true);


