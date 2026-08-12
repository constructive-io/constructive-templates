-- Verify: schemas/myapp_users_public/tables/users/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_users_public.users'::regclass, 'authenticated', 'INSERT', ARRAY['type', 'display_name', 'profile_picture', 'username'], true);


