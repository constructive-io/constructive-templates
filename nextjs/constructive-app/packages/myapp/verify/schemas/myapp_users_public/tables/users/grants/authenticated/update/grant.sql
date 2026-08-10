-- Verify: schemas/myapp_users_public/tables/users/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_users_public.users'::regclass, 'authenticated', 'UPDATE', ARRAY['username', 'display_name', 'profile_picture'], true);


