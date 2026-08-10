-- Verify: schemas/myapp_store_private/tables/user_secrets/policies/auth_upd_dir_own/policy


SELECT assert_policy('myapp_store_private.user_secrets'::regclass, 'auth_upd_dir_own', 'UPDATE', true, true, false);


