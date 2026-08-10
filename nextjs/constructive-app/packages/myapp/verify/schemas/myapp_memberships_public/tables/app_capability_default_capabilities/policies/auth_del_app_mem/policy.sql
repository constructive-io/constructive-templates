-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/policies/auth_del_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_capability_default_capabilities'::regclass, 'auth_del_app_mem', 'DELETE', true, true, false);


