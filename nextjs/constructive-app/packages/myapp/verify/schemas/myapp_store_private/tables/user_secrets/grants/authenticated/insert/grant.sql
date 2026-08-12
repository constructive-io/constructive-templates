-- Verify: schemas/myapp_store_private/tables/user_secrets/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_store_private.user_secrets'::regclass, 'authenticated', 'INSERT', NULL, true);


