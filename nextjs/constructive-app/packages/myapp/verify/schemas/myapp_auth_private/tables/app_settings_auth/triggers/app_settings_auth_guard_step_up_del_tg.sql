-- Verify: schemas/myapp_auth_private/tables/app_settings_auth/triggers/app_settings_auth_guard_step_up_del_tg


SELECT assert_trigger('myapp_auth_private.app_settings_auth'::regclass, 'app_settings_auth_guard_step_up_del_tg', 'myapp_app_private.app_settings_auth_guard_step_up_del_fn'::regproc, 11);


