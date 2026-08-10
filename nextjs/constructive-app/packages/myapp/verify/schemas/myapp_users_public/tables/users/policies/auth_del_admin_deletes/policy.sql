-- Verify: schemas/myapp_users_public/tables/users/policies/auth_del_admin_deletes/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_del_admin_deletes', 'DELETE', true, true, false);


