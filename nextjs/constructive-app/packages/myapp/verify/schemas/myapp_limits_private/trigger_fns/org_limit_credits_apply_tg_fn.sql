-- Verify: schemas/myapp_limits_private/trigger_fns/org_limit_credits_apply_tg_fn


SELECT assert_function('myapp_limits_private.org_limit_credits_apply_tg_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


