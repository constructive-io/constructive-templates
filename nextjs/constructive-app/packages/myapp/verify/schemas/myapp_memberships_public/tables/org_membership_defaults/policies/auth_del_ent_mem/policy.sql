-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/policies/auth_del_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_membership_defaults'::regclass, 'auth_del_ent_mem', 'DELETE', true, true, false);


