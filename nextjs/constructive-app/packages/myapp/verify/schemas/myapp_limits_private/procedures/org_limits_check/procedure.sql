-- Verify: schemas/myapp_limits_private/procedures/org_limits_check/procedure


SELECT assert_function('myapp_limits_private.org_limits_check(citext, uuid, bigint, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


