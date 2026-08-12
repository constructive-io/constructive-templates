-- Verify: schemas/myapp_limits_private/procedures/org_limits_check_soft/procedure


SELECT assert_function('myapp_limits_private.org_limits_check_soft(citext, uuid, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


