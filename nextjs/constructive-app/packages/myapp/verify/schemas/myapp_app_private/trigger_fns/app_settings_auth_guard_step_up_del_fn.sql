-- Verify: schemas/myapp_app_private/trigger_fns/app_settings_auth_guard_step_up_del_fn


SELECT assert_function('myapp_app_private.app_settings_auth_guard_step_up_del_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'STABLE');


