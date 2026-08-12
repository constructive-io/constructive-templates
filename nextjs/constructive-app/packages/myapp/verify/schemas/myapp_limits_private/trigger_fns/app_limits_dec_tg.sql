-- Verify: schemas/myapp_limits_private/trigger_fns/app_limits_dec_tg


SELECT assert_function('myapp_limits_private.app_limits_dec_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


