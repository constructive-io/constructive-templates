-- Verify: schemas/myapp_memberships_private/trigger_fns/org_memberships_itg


SELECT assert_function('myapp_memberships_private.org_memberships_itg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


