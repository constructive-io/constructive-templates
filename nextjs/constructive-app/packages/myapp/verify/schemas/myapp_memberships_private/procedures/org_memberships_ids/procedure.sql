-- Verify: schemas/myapp_memberships_private/procedures/org_memberships_ids/procedure


SELECT assert_function('myapp_memberships_private.org_memberships_ids()'::regprocedure, 'uuid[]'::regtype, false, true, 'STABLE');


