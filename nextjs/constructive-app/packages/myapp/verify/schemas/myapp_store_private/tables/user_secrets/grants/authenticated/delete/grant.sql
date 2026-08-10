-- Verify: schemas/myapp_store_private/tables/user_secrets/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_store_private.user_secrets'::regclass, 'authenticated', 'DELETE', NULL, true);


