-- Verify: schemas/myapp_users_public/tables/users/policies/auth_ins_insert_chk/policy


SELECT assert_policy('myapp_users_public.users'::regclass, 'auth_ins_insert_chk', 'INSERT', true, false, true);


