-- Verify: schemas/myapp_auth_private/tables/app_settings_device/indexes/app_settings_device_updated_at_idx


SELECT assert_index('myapp_auth_private.app_settings_device_updated_at_idx'::regclass, 'myapp_auth_private.app_settings_device'::regclass, false);


