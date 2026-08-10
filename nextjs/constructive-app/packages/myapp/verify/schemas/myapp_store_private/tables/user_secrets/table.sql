-- Verify: schemas/myapp_store_private/tables/user_secrets/table


SELECT assert_table('myapp_store_private.user_secrets'::regclass, false, NULL);


