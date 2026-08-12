-- Verify: schemas/myapp_invites_public/tables/app_invites/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_invites_public.app_invites'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


