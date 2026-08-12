-- Verify: schemas/myapp_auth_private/tables/app_settings_device/indexes/app_settings_device_updated_at_idx


SELECT verify_index('myapp_auth_private.app_settings_device', 'app_settings_device_updated_at_idx');


