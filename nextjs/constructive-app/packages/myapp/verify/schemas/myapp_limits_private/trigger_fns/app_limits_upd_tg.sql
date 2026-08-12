-- Verify: schemas/myapp_limits_private/trigger_fns/app_limits_upd_tg


SELECT assert_function('myapp_limits_private.app_limits_upd_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


