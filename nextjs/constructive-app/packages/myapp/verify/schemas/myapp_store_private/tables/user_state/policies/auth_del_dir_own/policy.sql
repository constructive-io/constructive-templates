-- Verify: schemas/myapp_store_private/tables/user_state/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_store_private.user_state'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


