-- Verify: schemas/myapp_users_public/tables/user_settings_security/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_users_public.user_settings_security'::regclass, 'authenticated', 'SELECT', NULL, true);


