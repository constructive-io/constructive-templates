-- Verify: schemas/myapp_profiles_private/trigger_fns/app_memberships_default_profile_tg


SELECT assert_function('myapp_profiles_private.app_memberships_default_profile_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


