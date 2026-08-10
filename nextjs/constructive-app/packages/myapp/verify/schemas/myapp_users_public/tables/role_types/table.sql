-- Verify: schemas/myapp_users_public/tables/role_types/table


SELECT assert_table('myapp_users_public.role_types'::regclass, false, NULL);


