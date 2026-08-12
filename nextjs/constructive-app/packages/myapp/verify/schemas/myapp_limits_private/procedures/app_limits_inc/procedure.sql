-- Verify: schemas/myapp_limits_private/procedures/app_limits_inc/procedure


SELECT assert_function('myapp_limits_private.app_limits_inc(citext, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


