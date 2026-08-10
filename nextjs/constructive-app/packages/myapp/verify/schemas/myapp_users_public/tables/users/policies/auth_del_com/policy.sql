-- Verify: schemas/myapp_users_public/tables/users/policies/auth_del_com/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_del_com', 'DELETE', true, true, false);


