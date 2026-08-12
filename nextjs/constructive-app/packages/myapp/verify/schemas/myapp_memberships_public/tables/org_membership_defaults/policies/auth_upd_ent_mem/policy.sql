-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/policies/auth_upd_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_membership_defaults'::regclass, 'auth_upd_ent_mem', 'UPDATE', true, true, false);


