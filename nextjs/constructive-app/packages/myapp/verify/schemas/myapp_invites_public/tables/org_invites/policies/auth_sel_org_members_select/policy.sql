-- Verify: schemas/myapp_invites_public/tables/org_invites/policies/auth_sel_org_members_select/policy


SELECT assert_policy('myapp_invites_public.org_invites'::regclass, 'auth_sel_org_members_select', 'SELECT', true, true, false);


