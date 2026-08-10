-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/policies/auth_sel_sender/policy


SELECT assert_policy('myapp_invites_public.org_claimed_invites'::regclass, 'auth_sel_sender', 'SELECT', true, true, false);


