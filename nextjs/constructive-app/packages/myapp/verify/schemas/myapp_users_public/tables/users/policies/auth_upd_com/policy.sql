-- Verify: schemas/myapp_users_public/tables/users/policies/auth_upd_com/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_upd_com', 'UPDATE', true, true, false);


