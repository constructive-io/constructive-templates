-- Verify: schemas/myapp_store_private/tables/user_state/table


SELECT assert_table('myapp_store_private.user_state'::regclass, false, NULL);


