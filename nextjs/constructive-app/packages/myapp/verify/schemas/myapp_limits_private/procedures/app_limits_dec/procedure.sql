-- Verify: schemas/myapp_limits_private/procedures/app_limits_dec/procedure


SELECT assert_function('myapp_limits_private.app_limits_dec(citext, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


