-- Verify: schemas/myapp_users_public/tables/user_settings_security/table


SELECT assert_table('myapp_users_public.user_settings_security'::regclass, false, NULL);


