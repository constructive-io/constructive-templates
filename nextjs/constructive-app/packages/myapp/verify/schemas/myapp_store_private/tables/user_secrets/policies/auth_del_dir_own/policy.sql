-- Verify: schemas/myapp_store_private/tables/user_secrets/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_store_private.user_secrets'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


