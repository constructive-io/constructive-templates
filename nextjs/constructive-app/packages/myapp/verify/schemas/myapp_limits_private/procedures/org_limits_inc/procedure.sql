-- Verify: schemas/myapp_limits_private/procedures/org_limits_inc/procedure


SELECT assert_function('myapp_limits_private.org_limits_inc(citext, uuid, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


