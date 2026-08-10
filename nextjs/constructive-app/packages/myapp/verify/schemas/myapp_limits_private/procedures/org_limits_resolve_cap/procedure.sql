-- Verify: schemas/myapp_limits_private/procedures/org_limits_resolve_cap/procedure


SELECT assert_function('myapp_limits_private.org_limits_resolve_cap(citext, uuid)'::regprocedure, 'bigint'::regtype, false, true, 'STABLE');


