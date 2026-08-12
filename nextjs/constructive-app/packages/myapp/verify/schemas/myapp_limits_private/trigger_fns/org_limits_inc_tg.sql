-- Verify: schemas/myapp_limits_private/trigger_fns/org_limits_inc_tg


SELECT assert_function('myapp_limits_private.org_limits_inc_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


