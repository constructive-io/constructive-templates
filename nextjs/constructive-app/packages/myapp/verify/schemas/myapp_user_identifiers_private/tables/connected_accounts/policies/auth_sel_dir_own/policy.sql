-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_private.connected_accounts'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


