-- Verify: schemas/myapp_users_public/tables/users/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_users_public.users'::regclass, 'authenticated', 'DELETE', NULL, true);


