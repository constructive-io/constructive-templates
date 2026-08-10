-- Verify: schemas/myapp_auth_private/tables/app_settings_auth/indexes/app_settings_auth_created_at_idx


SELECT assert_index('myapp_auth_private.app_settings_auth_created_at_idx'::regclass, 'myapp_auth_private.app_settings_auth'::regclass, false);


