-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_private.connected_accounts'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


