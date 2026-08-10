-- Verify: schemas/myapp_auth_private/tables/app_settings_device/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_private.app_settings_device'::regclass, 'authenticated', 'SELECT', NULL, true);


