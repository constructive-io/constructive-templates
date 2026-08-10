-- Verify: schemas/myapp_auth_private/tables/app_settings_device/table


SELECT assert_table('myapp_auth_private.app_settings_device'::regclass, false, NULL);


