-- Verify: schemas/myapp_profiles_private/trigger_fns/org_profile_capabilities_recompute_tg


SELECT assert_function('myapp_profiles_private.org_profile_capabilities_recompute_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


