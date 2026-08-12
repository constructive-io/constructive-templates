-- Verify: schemas/myapp_limits_private/procedures/org_limit_aggregates_dec/procedure


SELECT assert_function('myapp_limits_private.org_limit_aggregates_dec(citext, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


