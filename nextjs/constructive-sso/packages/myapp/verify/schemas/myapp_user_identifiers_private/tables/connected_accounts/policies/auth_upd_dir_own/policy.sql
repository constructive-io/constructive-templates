-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/auth_upd_dir_own/policy


SELECT verify_policy('auth_upd_dir_own', 'myapp_user_identifiers_private.connected_accounts');


