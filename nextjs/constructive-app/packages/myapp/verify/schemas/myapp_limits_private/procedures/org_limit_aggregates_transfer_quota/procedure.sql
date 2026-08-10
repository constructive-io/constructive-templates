-- Verify: schemas/myapp_limits_private/procedures/org_limit_aggregates_transfer_quota/procedure


SELECT assert_function('myapp_limits_private.org_limit_aggregates_transfer_quota(citext, uuid, uuid, bigint)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


