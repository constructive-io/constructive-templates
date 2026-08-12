-- Verify: schemas/myapp_limits_private/procedures/app_limits_check/procedure


SELECT assert_function('myapp_limits_private.app_limits_check(citext, bigint, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


