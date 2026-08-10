-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_membership_defaults'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


