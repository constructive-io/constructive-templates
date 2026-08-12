-- Verify: schemas/myapp_store_private/tables/user_state/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_store_private.user_state'::regclass, 'authenticated', 'DELETE', NULL, true);


