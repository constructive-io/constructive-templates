-- Verify: schemas/myapp_memberships_private/trigger_fns/app_memberships_utg


SELECT assert_function('myapp_memberships_private.app_memberships_utg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


