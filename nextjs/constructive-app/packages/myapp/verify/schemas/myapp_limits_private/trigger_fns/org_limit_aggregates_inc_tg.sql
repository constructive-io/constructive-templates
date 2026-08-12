-- Verify: schemas/myapp_limits_private/trigger_fns/org_limit_aggregates_inc_tg


SELECT assert_function('myapp_limits_private.org_limit_aggregates_inc_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


