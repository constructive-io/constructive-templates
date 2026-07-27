-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/delete/grant


SELECT verify_table_grant('myapp_auth_private.auth_user_devices', 'delete', 'authenticated');


