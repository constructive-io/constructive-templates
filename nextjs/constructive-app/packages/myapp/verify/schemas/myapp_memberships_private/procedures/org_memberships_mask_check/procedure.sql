-- Verify: schemas/myapp_memberships_private/procedures/org_memberships_mask_check/procedure


SELECT assert_function('myapp_memberships_private.org_memberships_mask_check(bit varying, uuid, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');


