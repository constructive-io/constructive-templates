-- Verify: schemas/myapp_memberships_private/trigger_fns/app_mbr_create


SELECT assert_function('myapp_memberships_private.app_mbr_create()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


