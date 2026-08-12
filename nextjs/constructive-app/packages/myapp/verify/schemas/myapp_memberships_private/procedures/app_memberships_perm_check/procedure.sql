-- Verify: schemas/myapp_memberships_private/procedures/app_memberships_perm_check/procedure


SELECT assert_function('myapp_memberships_private.app_memberships_perm_check(text, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');


