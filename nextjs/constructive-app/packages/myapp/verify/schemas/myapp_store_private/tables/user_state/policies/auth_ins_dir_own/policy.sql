-- Verify: schemas/myapp_store_private/tables/user_state/policies/auth_ins_dir_own/policy


SELECT assert_policy('myapp_store_private.user_state'::regclass, 'auth_ins_dir_own', 'INSERT', true, false, true);


