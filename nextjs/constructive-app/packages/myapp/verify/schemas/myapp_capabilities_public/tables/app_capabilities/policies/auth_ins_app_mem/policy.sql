-- Verify: schemas/myapp_capabilities_public/tables/app_capabilities/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_capabilities_public.app_capabilities'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


