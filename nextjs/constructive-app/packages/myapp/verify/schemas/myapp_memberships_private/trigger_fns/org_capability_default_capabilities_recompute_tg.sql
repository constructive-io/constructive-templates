-- Verify: schemas/myapp_memberships_private/trigger_fns/org_capability_default_capabilities_recompute_tg


SELECT assert_function('myapp_memberships_private.org_capability_default_capabilities_recompute_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


