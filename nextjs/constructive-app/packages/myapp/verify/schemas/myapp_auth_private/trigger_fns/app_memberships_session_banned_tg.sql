-- Verify: schemas/myapp_auth_private/trigger_fns/app_memberships_session_banned_tg


SELECT assert_function('myapp_auth_private.app_memberships_session_banned_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


