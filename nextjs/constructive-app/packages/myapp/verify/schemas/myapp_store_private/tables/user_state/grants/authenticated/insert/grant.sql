-- Verify: schemas/myapp_store_private/tables/user_state/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_store_private.user_state'::regclass, 'authenticated', 'INSERT', NULL, true);


