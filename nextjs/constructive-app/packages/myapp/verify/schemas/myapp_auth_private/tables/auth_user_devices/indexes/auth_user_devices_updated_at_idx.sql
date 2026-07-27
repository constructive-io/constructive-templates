-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_updated_at_idx


SELECT verify_index('myapp_auth_private.auth_user_devices', 'auth_user_devices_updated_at_idx');


