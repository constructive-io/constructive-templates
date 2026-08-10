-- Verify: schemas/myapp_limits_private/procedures/org_limit_aggregates_check_soft/procedure


SELECT assert_function('myapp_limits_private.org_limit_aggregates_check_soft(citext, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


