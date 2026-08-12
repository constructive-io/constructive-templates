-- Verify: schemas/myapp_auth_private/tables/app_settings_rate_limit/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_auth_private.app_settings_rate_limit'::regclass, 'authenticated', 'UPDATE', NULL, true);


