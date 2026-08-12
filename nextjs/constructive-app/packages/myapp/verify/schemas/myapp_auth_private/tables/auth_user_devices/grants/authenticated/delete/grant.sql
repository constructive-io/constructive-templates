-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_auth_private.auth_user_devices'::regclass, 'authenticated', 'DELETE', NULL, true);


