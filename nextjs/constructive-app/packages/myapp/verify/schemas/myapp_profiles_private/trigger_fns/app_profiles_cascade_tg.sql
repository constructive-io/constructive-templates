-- Verify: schemas/myapp_profiles_private/trigger_fns/app_profiles_cascade_tg


SELECT assert_function('myapp_profiles_private.app_profiles_cascade_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


