-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/policies/auth_del_ent_mem/policy


SELECT assert_policy('myapp_capabilities_public.org_capability_defaults'::regclass, 'auth_del_ent_mem', 'DELETE', true, true, false);


