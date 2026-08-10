-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_store_private.app_internal_secrets'::regclass, 'authenticated', 'UPDATE', NULL, true);


