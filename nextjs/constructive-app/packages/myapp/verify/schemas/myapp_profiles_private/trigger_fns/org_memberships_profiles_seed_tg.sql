-- Verify: schemas/myapp_profiles_private/trigger_fns/org_memberships_profiles_seed_tg


SELECT assert_function('myapp_profiles_private.org_memberships_profiles_seed_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


