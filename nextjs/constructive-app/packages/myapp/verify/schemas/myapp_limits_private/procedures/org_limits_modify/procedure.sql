-- Verify: schemas/myapp_limits_private/procedures/org_limits_modify/procedure


SELECT assert_function('myapp_limits_private.org_limits_modify(citext, uuid, bigint, text, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


