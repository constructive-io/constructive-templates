-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_membership_settings'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


