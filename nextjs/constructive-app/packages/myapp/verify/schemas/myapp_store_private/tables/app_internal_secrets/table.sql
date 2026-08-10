-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/table


SELECT assert_table('myapp_store_private.app_internal_secrets'::regclass, false, NULL);


