-- Verify: schemas/myapp_invites_public/tables/app_claimed_invites/policies/auth_sel_receiver/policy


SELECT assert_policy('myapp_invites_public.app_claimed_invites'::regclass, 'auth_sel_receiver', 'SELECT', true, true, false);


