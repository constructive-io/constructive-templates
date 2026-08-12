-- Verify: schemas/myapp_capabilities_public/tables/org_capabilities/policies/auth_del_app_mem/policy


SELECT assert_policy('myapp_capabilities_public.org_capabilities'::regclass, 'auth_del_app_mem', 'DELETE', true, true, false);


