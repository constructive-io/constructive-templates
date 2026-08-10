-- Verify: schemas/myapp_profiles_private/trigger_fns/org_memberships_default_profile_tg


SELECT assert_function('myapp_profiles_private.org_memberships_default_profile_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


