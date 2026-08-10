-- Verify: schemas/myapp_app_private/trigger_fns/principal_scope_overrides_guard_step_up_del_fn


SELECT assert_function('myapp_app_private.principal_scope_overrides_guard_step_up_del_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'STABLE');


