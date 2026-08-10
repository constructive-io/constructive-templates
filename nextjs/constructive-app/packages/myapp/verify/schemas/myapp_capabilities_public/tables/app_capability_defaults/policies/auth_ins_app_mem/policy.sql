-- Verify: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_capabilities_public.app_capability_defaults'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


