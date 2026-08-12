-- Verify: schemas/myapp_users_public/tables/users/policies/auth_upd_admin_updates/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_upd_admin_updates', 'UPDATE', true, true, false);


