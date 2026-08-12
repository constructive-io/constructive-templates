-- Verify: schemas/myapp_invites_public/tables/org_invites/policies/auth_upd_dir_own/policy


SELECT assert_policy('myapp_invites_public.org_invites'::regclass, 'auth_upd_dir_own', 'UPDATE', true, true, false);


