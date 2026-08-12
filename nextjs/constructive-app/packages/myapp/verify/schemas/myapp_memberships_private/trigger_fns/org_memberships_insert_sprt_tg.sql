-- Verify: schemas/myapp_memberships_private/trigger_fns/org_memberships_insert_sprt_tg


SELECT assert_function('myapp_memberships_private.org_memberships_insert_sprt_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


