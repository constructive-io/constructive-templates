-- Verify: schemas/myapp_memberships_private/trigger_fns/org_membership_settings_seed_fn


SELECT assert_function('myapp_memberships_private.org_membership_settings_seed_fn()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


