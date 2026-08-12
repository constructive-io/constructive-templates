-- Verify: schemas/myapp_limits_private/trigger_fns/app_limits_audit_tg_fn


SELECT assert_function('myapp_limits_private.app_limits_audit_tg_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


