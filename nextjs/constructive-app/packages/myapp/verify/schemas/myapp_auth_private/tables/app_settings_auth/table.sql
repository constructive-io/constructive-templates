-- Verify: schemas/myapp_auth_private/tables/app_settings_auth/table


SELECT assert_table('myapp_auth_private.app_settings_auth'::regclass, false, NULL);


