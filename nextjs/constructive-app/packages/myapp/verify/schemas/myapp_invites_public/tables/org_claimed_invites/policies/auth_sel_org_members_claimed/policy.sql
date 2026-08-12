-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/policies/auth_sel_org_members_claimed/policy


SELECT assert_policy('myapp_invites_public.org_claimed_invites'::regclass, 'auth_sel_org_members_claimed', 'SELECT', true, true, false);


