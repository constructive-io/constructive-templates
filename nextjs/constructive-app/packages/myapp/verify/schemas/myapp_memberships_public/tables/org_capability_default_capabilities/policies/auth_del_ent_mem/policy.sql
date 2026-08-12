-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/policies/auth_del_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_capability_default_capabilities'::regclass, 'auth_del_ent_mem', 'DELETE', true, true, false);


