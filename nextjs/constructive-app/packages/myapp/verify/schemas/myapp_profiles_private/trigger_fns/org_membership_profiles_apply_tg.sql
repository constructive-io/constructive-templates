-- Verify: schemas/myapp_profiles_private/trigger_fns/org_membership_profiles_apply_tg


SELECT assert_function('myapp_profiles_private.org_membership_profiles_apply_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


