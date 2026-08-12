-- Verify: schemas/myapp_invites_private/trigger_fns/app_invites_profile_check_tg


SELECT assert_function('myapp_invites_private.app_invites_profile_check_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


