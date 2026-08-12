-- Verify: schemas/myapp_capabilities_public/tables/app_capabilities/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_capabilities_public.app_capabilities'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


