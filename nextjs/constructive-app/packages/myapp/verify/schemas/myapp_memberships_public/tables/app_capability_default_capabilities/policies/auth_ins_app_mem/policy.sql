-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_capability_default_capabilities'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


