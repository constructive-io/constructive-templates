-- Verify: schemas/myapp_limits_private/trigger_fns/org_limits_cap_check_tg_fn


SELECT assert_function('myapp_limits_private.org_limits_cap_check_tg_fn()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


