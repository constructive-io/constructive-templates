-- Verify: schemas/myapp_memberships_private/trigger_fns/app_memberships_itg


SELECT assert_function('myapp_memberships_private.app_memberships_itg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


