-- Verify: schemas/myapp_profiles_private/trigger_fns/org_membership_profiles_remove_tg


SELECT assert_function('myapp_profiles_private.org_membership_profiles_remove_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


