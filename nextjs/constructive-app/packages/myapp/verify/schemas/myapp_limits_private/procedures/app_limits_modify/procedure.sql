-- Verify: schemas/myapp_limits_private/procedures/app_limits_modify/procedure


SELECT assert_function('myapp_limits_private.app_limits_modify(citext, bigint, text, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


