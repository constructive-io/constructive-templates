-- Verify: schemas/myapp_users_public/tables/users/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


