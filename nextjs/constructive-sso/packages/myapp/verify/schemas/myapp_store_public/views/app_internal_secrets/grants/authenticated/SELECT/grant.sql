-- Verify: schemas/myapp_store_public/views/app_internal_secrets/grants/authenticated/SELECT/grant


SELECT verify_table_grant('myapp_store_public.app_internal_secrets', 'SELECT', 'authenticated');


