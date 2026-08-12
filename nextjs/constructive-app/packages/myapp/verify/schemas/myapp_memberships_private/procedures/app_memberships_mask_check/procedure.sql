-- Verify: schemas/myapp_memberships_private/procedures/app_memberships_mask_check/procedure


SELECT assert_function('myapp_memberships_private.app_memberships_mask_check(bit varying, uuid)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');


