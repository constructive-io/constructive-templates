-- Verify: schemas/myapp_profiles_private/trigger_fns/app_memberships_profiles_seed_tg


SELECT assert_function('myapp_profiles_private.app_memberships_profiles_seed_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


