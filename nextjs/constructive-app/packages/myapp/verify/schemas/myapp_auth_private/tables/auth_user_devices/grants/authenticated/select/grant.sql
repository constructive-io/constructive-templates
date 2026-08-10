-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_private.auth_user_devices'::regclass, 'authenticated', 'SELECT', NULL, true);


