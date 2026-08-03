-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_private.auth_user_devices', 'SELECT', 'authenticated');


