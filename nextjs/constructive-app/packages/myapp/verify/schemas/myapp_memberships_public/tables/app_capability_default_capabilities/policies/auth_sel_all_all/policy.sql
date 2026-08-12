-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_memberships_public.app_capability_default_capabilities'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


