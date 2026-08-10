-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_capabilities_public.org_capabilities'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


