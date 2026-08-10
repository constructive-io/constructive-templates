-- Verify: schemas/myapp_auth_private/tables/identity_providers/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_auth_private.identity_providers'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


