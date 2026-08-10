-- Verify: schemas/myapp_auth_private/tables/app_settings_rate_limit/table


SELECT assert_table('myapp_auth_private.app_settings_rate_limit'::regclass, false, NULL);


