-- Verify: schemas/myapp_auth_public/tables/principals/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_auth_public.principals'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


