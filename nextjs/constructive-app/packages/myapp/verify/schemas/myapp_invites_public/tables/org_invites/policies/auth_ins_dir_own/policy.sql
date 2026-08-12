-- Verify: schemas/myapp_invites_public/tables/org_invites/policies/auth_ins_dir_own/policy


SELECT assert_policy('myapp_invites_public.org_invites'::regclass, 'auth_ins_dir_own', 'INSERT', true, false, true);


