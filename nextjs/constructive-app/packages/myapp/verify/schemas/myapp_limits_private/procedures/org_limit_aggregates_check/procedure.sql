-- Verify: schemas/myapp_limits_private/procedures/org_limit_aggregates_check/procedure


SELECT assert_function('myapp_limits_private.org_limit_aggregates_check(citext, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


