-- Verify: schemas/myapp_profiles_private/trigger_fns/app_membership_profiles_apply_tg


SELECT assert_function('myapp_profiles_private.app_membership_profiles_apply_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


