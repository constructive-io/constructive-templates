-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/table


SELECT assert_table('myapp_auth_private.auth_user_devices'::regclass, false, NULL);


