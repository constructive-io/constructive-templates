-- Verify: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/auth_del_app_mem/policy


SELECT assert_policy('myapp_capabilities_public.app_capability_defaults'::regclass, 'auth_del_app_mem', 'DELETE', true, true, false);


