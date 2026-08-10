-- Verify: schemas/myapp_capabilities_public/tables/org_capability_defaults/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_capabilities_public.org_capability_defaults'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


