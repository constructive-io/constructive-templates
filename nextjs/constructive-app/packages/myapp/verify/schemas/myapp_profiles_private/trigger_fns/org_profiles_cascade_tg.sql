-- Verify: schemas/myapp_profiles_private/trigger_fns/org_profiles_cascade_tg


SELECT assert_function('myapp_profiles_private.org_profiles_cascade_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


