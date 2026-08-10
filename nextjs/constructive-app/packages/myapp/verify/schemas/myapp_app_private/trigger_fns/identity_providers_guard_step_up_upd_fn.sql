-- Verify: schemas/myapp_app_private/trigger_fns/identity_providers_guard_step_up_upd_fn


SELECT assert_function('myapp_app_private.identity_providers_guard_step_up_upd_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'STABLE');


