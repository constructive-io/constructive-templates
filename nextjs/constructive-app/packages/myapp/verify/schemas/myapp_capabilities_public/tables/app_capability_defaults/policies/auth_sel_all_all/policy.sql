-- Verify: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_capabilities_public.app_capability_defaults'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


