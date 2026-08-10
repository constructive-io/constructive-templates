-- Verify: schemas/myapp_limits_private/procedures/org_limit_aggregates_modify/procedure


SELECT assert_function('myapp_limits_private.org_limit_aggregates_modify(citext, uuid, bigint, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


