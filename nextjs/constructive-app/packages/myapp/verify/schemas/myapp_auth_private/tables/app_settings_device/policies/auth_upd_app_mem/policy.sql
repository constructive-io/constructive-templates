-- Verify: schemas/myapp_auth_private/tables/app_settings_device/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_auth_private.app_settings_device'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


