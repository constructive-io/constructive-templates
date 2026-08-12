-- Verify: schemas/myapp_auth_private/tables/app_settings_auth/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.app_settings_auth'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


