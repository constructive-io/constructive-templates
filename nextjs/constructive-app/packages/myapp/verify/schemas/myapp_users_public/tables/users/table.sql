-- Verify: schemas/myapp_users_public/tables/users/table


SELECT assert_table('myapp_users_public.users'::regclass, false, NULL);


