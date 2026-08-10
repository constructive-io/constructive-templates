-- Verify: schemas/myapp_memberships_private/trigger_fns/org_capability_default_grants_apply_tg


SELECT assert_function('myapp_memberships_private.org_capability_default_grants_apply_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


