-- Verify: schemas/myapp_limits_private/procedures/app_limits_resolve_cap/procedure


SELECT assert_function('myapp_limits_private.app_limits_resolve_cap(citext)'::regprocedure, 'bigint'::regtype, false, true, 'STABLE');


