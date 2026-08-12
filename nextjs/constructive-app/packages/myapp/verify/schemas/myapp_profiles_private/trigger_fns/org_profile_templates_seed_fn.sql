-- Verify: schemas/myapp_profiles_private/trigger_fns/org_profile_templates_seed_fn


SELECT assert_function('myapp_profiles_private.org_profile_templates_seed_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


