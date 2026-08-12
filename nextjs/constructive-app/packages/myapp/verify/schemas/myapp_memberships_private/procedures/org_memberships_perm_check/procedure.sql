-- Verify: schemas/myapp_memberships_private/procedures/org_memberships_perm_check/procedure


SELECT assert_function('myapp_memberships_private.org_memberships_perm_check(text, uuid, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');


