-- Verify: schemas/myapp_memberships_private/trigger_fns/app_memberships_update_sprt_tg


SELECT assert_function('myapp_memberships_private.app_memberships_update_sprt_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


